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
      if Article.find_by title: article["title"]
        @article = Article.find_by title: article["title"]
      else
        @article = Article.create(article)
      end
      Entry.create(article: @article, comparison: @comparison)
    end
  end
end
