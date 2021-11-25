class EntriesController < ApplicationController
  def create_entries
    @comparison = Comparison.find(params[:comparison_id])
    @data = @comparison.articles_one
    @articles_one = JSON.parse(@data)["data"]

    @data = @comparison.articles_two
    @articles_two = JSON.parse(@data)["data"]

    create_iterator(@articles_one)
    create_iterator(@articles_two)
    redirect_to board_path
  end

  private

  def create_iterator(array)
    array.each do |article|
      token_api = (article["published_at"].to_s + article["title"]).gsub(/\s+/, "")
      if Article.find_by token: token_api
        @article = Article.find_by token: token_api
      else
        @article = Article.create(article)
        token = (@article.published_at.to_s + @article.title).gsub(/\s+/, "")
        @Article.update(token: token)
      end
      Entry.create(article: @article, comparison: @comparison)
    end
  end
end
