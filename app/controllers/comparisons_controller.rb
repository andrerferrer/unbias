require 'faraday'
require 'json'
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
    generate_markers(@articles)
  end

  def generate_markers(articles)
    @sources = Source.where(source_keyword: articles.map { |article| article["source"] })
              .or(Source.where(name: articles.map { |article| article["source"] }))

    @markers = @sources.geocoded.map do |source|
      {
        lat: source.latitude,
        lng: source.longitude,
        image_url: helpers.asset_url('cnn-logo.png')
        # info_window: render_to_string(partial: "info_window")
      }
    end
  end

  def update
    @comparison = Comparison.find(params[:id])
    if @comparison.update(publisher_one: params[:comparison][:publisher_one],
                          publisher_two: params[:comparison][:publisher_two])
      redirect_to comparison_path(@comparison)
    else
      :update
    end
  end

  def show
    @comparison = Comparison.find(params[:id])
    build_url(@comparison)
    payload(@url_one)
    @articles_one = JSON.parse(@response.body)["data"]

    @comparison.update(articles_one: @response.body)

    payload(@url_two)
    @articles_two = JSON.parse(@response.body)["data"]
    @comparison.update(articles_two: @response.body)
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

    # date = "&date=#{params[:start_date]}#{params[:end_date]}"
    # Testing date: date = "&date=2020-12-24,2020-12-31"

    # Add #{date} to url
    sources = []
    Source.all.each do |source|
      sources << source['source_keyword']
    end
    @url_worldmap = "#{BASE_URL}#{keyword}#{date}&sources=#{sources.join(',')},-cnn,-bbc&limit=100"
    @url_cnn_worldmap = "#{BASE_URL}#{keyword}#{date}&sources=cnn&limit=15"
    @url_bbc_worldmap = "#{BASE_URL}#{keyword}#{date}&sources=bbc&limit=15"
    # @url_worldmap = "#{BASE_URL}#{keyword}#{date}&limit=100&sources=chinadigitaltimes"
    @url_one = "#{BASE_URL}#{keyword}#{date}#{publisher_one}#{country_one}"
    @url_two = "#{BASE_URL}#{keyword}#{date}#{publisher_two}#{country_two}"
    # Needs to be this format - probably need some date transformation: &date=2020-12-24,2020-12-3
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
