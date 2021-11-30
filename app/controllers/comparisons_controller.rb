require 'faraday'
require 'json'
require 'textmood'
# maybe open-uri?
BASE_URL = "http://api.mediastack.com/v1/news?access_key=bc6099508dd0e4321fbe33e136b8cd96&languages=en"

class ComparisonsController < ApplicationController
  # before_action :show, :filter_sources
  def create
    @comparison = Comparison.new(strong_params)
    @comparison.user = current_user
    if @comparison.save
      redirect_to worldmap_comparison_path(@comparison)
    else
      render 'pages/home'
    end
  end

  def worldmap
    @comparison = Comparison.find(params[:id])
    build_url(@comparison)

    payload(@url_cnn_worldmap)
    @articles_cnn = JSON.parse(@response.body)["data"]

    payload(@url_bbc_worldmap)
    @articles_bbc = JSON.parse(@response.body)["data"]
    payload(@url_worldmap)
    @articles = JSON.parse(@response.body)["data"]
    avg_textmood(@articles)
    generate_markers(@articles)
  end

  def tally(articles)
    tally = articles.map { |article| article["source"] }.tally
    tally_2 = tally.map { |s| s[0] == /cnn/ }.tally

  end

  def generate_markers(articles)
    @sources = Source.where(source_keyword: articles.map { |article| article["source"] })
              .or(Source.where(name: articles.map { |article| article["source"] }))
    @tally = tally(articles)
    # @tally[source['source_keyword']].to_i.times do
      @markers = @sources.geocoded.map do |source|
          {
            lat: source.latitude,
            lng: source.longitude,
            info_window: render_to_string(partial: "info_window", locals: { source: source, articles: articles }),
            image_url: helpers.asset_url(source.img)
            # info_window: render_to_string(partial: "info_window")
          }


      end



  end

  def update
    @comparison = Comparison.find(params[:id])
    if params[:comparison][:topic]
      if @comparison.update(topic: params[:comparison][:topic],
                            start_date: params[:comparison][:start_date],
                            end_date: params[:comparison][:end_date])
       redirect_to worldmap_comparison_path(@comparison)
      else
        :update
      end
    else
      if @comparison.update(publisher_one: params[:comparison][:publisher_one],
                             publisher_two: params[:comparison][:publisher_two])
       redirect_to comparison_path(@comparison)
      else
        :update
      end
    end
    # @comparison.publisher_one = params[:comparison][:publisher_one]
    # @comparison.publisher_two = params[:comparison][:publisher_two]
    # @publisher_one = Source.find(params[:comparison][:publisher_one]).source_keyword
    # @publisher_two = Source.find(params[:comparison][:publisher_two]).source_keyword
  end

  def show
    @comparison = Comparison.find(params[:id])

    build_url(@comparison)
    payload(@url_one)
    @articles_one = JSON.parse(@response.body)["data"].first(5)
    @source = Source.where(name: @articles_one[0]["source"])
    @comparison.update(articles_one: JSON.parse(@response.body)["data"].to_json)
    @comparison.update(selected_articles_one: @articles_one.to_json)
    avg_textmood(@articles_one)

    payload(@url_two)
    @articles_two = JSON.parse(@response.body)["data"].first(5)
    @source_two = Source.where(name: @articles_two[0]["source"])
    @comparison.update(articles_two: JSON.parse(@response.body)["data"].to_json)
    @comparison.update(selected_articles_two: @articles_two.to_json)
    avg_textmood(@articles_two)
  end

  def avg_textmood(articles)
    tm = TextMood.new(language: "en", normalize_score: true)
    @source = Source.where(source_keyword: articles.map { |article| article["source"] })
         .or(Source.where(name: articles.map { |article| article["source"] }))
    @tally = articles.map { |article| article["source"] }.tally

    articles.each do |article|
      article["sentiment_title_score"] = tm.analyze(article["title"])
      article["sentiment_title_string"] = stringify_sentiment(tm.analyze(article["title"]))
      article["sentiment_description_score"] = tm.analyze(article["description"])
      article["sentiment_description_string"] = stringify_sentiment(tm.analyze(article["description"]))
    end

    @averages = []

    @tally.each do |key, value|
      sum_title = 0
      sum_description = 0
      filtered_articles = articles.select do |article|
        article[key] = key
      end
      filtered_articles.each do |article|
        sum_title += article["sentiment_title_score"]
        sum_description += article["sentiment_description_score"]
      end

      average_t = sum_title / value
      @average_title = stringify_sentiment(average_t)
      average_d = sum_description / value
      @average_description = stringify_sentiment(average_d)

      @averages << { "#{key} " => { average_title: @average_title, average_description: @average_description } }
    end
  end

  def stringify_sentiment(number)
    case number
    when 75..100
      "Overwhelmingly positive"
    when 50..74
      "Very positive"
    when 25..49
      "Positive"
    when 10..24
      "Quite positive"
    when -10..9
      "Neutral"
    when -25..-11
      "Quite negative"
    when -50..-26
      "Negative"
    when -75..-51
      "Very negative"
    when -100..-76
      "Overwhelmingly negative"
    else
      "Unknown"
    end
  end

  private

  def filter_sources

  end

  def strong_params
    params.require(:comparison).permit(:topic, :start_date, :end_date)
  end

  def build_url(comparison)
    keyword = "&keywords=#{comparison.topic}"
    date = "&date=#{comparison.start_date},#{comparison.end_date}"

    s_one = Source.where(id: @comparison.publisher_one)
    publisher_one = "&sources=#{s_one[0]["source_keyword"]}" if s_one[0] != nil

    s_two = Source.where(id: @comparison.publisher_two)
    publisher_two = "&sources=#{s_two[0]["source_keyword"]}" if s_two[0] != nil
    country_one = ""
    country_two = ""

    sources = []
    Source.all.each do |source|
      sources << source['source_keyword']
    end
    @url_worldmap = "#{BASE_URL}#{keyword}#{date}&sources=#{sources.join(',')},-cnn,-bbc&limit=100"
    @url_cnn_worldmap = "#{BASE_URL}#{keyword}#{date}&sources=cnn&limit=15"
    @url_bbc_worldmap = "#{BASE_URL}#{keyword}#{date}&sources=bbc&limit=15"

    @url_one = "#{BASE_URL}#{keyword}#{date}#{publisher_one}#{country_one}"
    @url_two = "#{BASE_URL}#{keyword}#{date}#{publisher_two}#{country_two}"
  end

  def payload(url)
    retries = 0
    begin
      @response = Faraday.get(url) do |req|
        req.options.open_timeout = 20
        req.options.timeout = 20
      end
    rescue URI::InvalidURIError => exception
      Rollbar.error(exception)

    rescue JSON::ParserError => exception
      Rollbar.error(exception)

    rescue Faraday::ConnectionFailed
      if (retries += 1) <= 3
        sleep(retries * 3)
        retry
      end

    rescue Faraday::TimeoutError
      if (retries += 1) <= 3
        sleep(retries * 3)
        retry
      end
    end
  end
end
