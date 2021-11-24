require 'faraday'
require 'json'
# maybe open-uri?
sources = "&sources=cnn,bbc"
countries = "&countries=gb,us,au"
BASE_URL = "http://api.mediastack.com/v1/news?access_key=bc6099508dd0e4321fbe33e136b8cd96&languages=en&sort=popularity#{countries}"

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
    payload
    @articles = JSON.parse(@response.body)["data"]
  end

  def update
    @comparison = Comparison.find(params[:id])
    @comparison.publisher_one = params[:publisher_one]
    @comparison.publisher_two = params[:publisher_two]
    # save in db?
  end

  private

  def strong_params
    params.require(:comparison).permit(:topic, :start_date, :end_date)
  end

  def build_url(comparison)
    # keyword = "&keywords=#{params[:comparison][:topic]}"

    keyword = "&keywords=#{comparison.topic}"
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
