require 'faraday'
require 'json'
# maybe open-uri?
sources = "&sources=cnn,bbc"
countries = "&countries=gb,us,au"
BASE_URL = "http://api.mediastack.com/v1/news?access_key=bc6099508dd0e4321fbe33e136b8cd96&languages=en&sort=popularity#{countries}"

class ArticlesController < ApplicationController
  def index
    build_url
    payload
    @data = JSON.parse(@response.body)
    @articles = @data["data"]

    # @markers = @articles.geocoded.map do |article|
    #   {
    #     lat: article.latitude,
    #     lng: article.longitude
    #   }
    # end
  end

  private

  def build_url
    # keyword = "&keywords=#{params[:topic]}"
    keyword = "&keywords=global%20warming"

    # date = "&date=#{params[:start_date]}#{params[:end_date]}"
    # Testing date: date = "&date=2020-12-24,2020-12-31"

    # Add #{date} to url
    @url = "#{BASE_URL}#{keyword}"

    # Needs to be this format - probably need some date transformation: &date=2020-12-24,2020-12-31
  end

  def payload
    retries = 0
    begin
      @response = Faraday.get(@url) do |req|
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
