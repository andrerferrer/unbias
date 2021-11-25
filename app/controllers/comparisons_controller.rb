require 'faraday'
require 'json'
# maybe open-uri?
BASE_URL = "http://api.mediastack.com/v1/news?access_key=bc6099508dd0e4321fbe33e136b8cd96&limit=100&languages=en&sort=popularity"

class ComparisonsController < ApplicationController
  def create
    @comparison = Comparison.new(strong_params)
    @comparison.user = current_user
    if @comparison.save
      redirect_to worldmap_comparison_path(@comparison)
    else
      redirect_to root_path
    end
  end

  def worldmap
    @comparison = Comparison.find(params[:id])
    build_url(@comparison)
    payload(@url_worldmap)
    @articles = JSON.parse(@response.body)["data"]
  end

  def update
    @comparison = Comparison.find(params[:id])

    # @comparison.publisher_one = params[:comparison][:publisher_one]
    # @comparison.publisher_two = params[:comparison][:publisher_two]
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

  def create_articles_and_entries
  end

  def strong_params
    params.require(:comparison).permit(:topic, :start_date, :end_date)
  end

  def build_url(comparison)
    keyword = "&keywords=#{comparison.topic}"
    date = "&date=#{comparison.start_date},#{comparison.end_date}"
    publisher_one = "&sources=#{comparison.publisher_one}"
    publisher_two = "&sources=#{comparison.publisher_two}"
    country_one = ""
    country_two = ""

    @url_worldmap = "#{BASE_URL}#{keyword}#{date}"
    @url_one = "#{@url_worldmap}#{publisher_one}#{country_one}"
    @url_two = "#{@url_worldmap}#{publisher_two}#{country_two}"
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
