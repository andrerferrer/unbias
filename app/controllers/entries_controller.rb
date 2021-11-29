class EntriesController < ApplicationController
  before_action :set_comparison, only: %i[create_entries add_article_one add_article_two remove_article_one remove_article_two]

  def create_entries
    @comparison.articles_one = @articles_one
    @comparison.articles_two = @articles_two

    create_iterator(@articles_one)
    create_iterator(@articles_two)

    redirect_to board_path
  end

  def add_article_one
    @articles_one.push(@articles_one_all.first)
    @articles_one_all.delete_at(0)
    @comparison.update(articles_one: @articles_one_all.to_json)
    @comparison.update(selected_articles_one: @articles_one.to_json)
  end

  def add_article_two
    @articles_two.push(@articles_two_all.first)
    @articles_two_all.delete_at(0)
    @comparison.update(articles_one: @articles_one_all.to_json)
    @comparison.update(selected_articles_two: @articles_two.to_json)
  end

  def remove_article_one
    index = @articles_one.index { |h| h["description"] == params["description"] }
    @articles_one.delete_at(index)
    @comparison.update(selected_articles_one: @articles_one.to_json)
  end

  def remove_article_two
    index = @articles_two.index { |h| h["description"] == params["description"] }
    @articles_two.delete_at(index)
    @comparison.update(selected_articles_two: @articles_two.to_json)
  end

  private

  def set_comparison
    @comparison = Comparison.find(params[:comparison_id])

    @data = @comparison.articles_one
    @articles_one_all = JSON.parse(@data).drop(5)
    @articles_one = JSON.parse(@comparison.selected_articles_one)

    @data = @comparison.articles_two
    @articles_two_all = JSON.parse(@data).drop(5)
    @articles_two = JSON.parse(@comparison.selected_articles_two)
    # @comparison.update(selected_articles: @articles_one_all.first(5))


    # @articles_two = @articles_two_all.first(5)

    # @articles_two_all.first(5).each do |article|
    #   @articles_two_all.delete(article)
    # end
  end

  def create_iterator(array)
    array.each do |article|
      token_api = (article["published_at"].to_s + article["title"]).gsub(/\s+/, "")
      if Article.find_by token: token_api
        @article = Article.find_by token: token_api
      else
        @article = Article.create(article)
        token = (@article.published_at.to_s + @article.title).gsub(/\s+/, "")
        @article.update(token: token)
      end
      Entry.create(article: @article, comparison: @comparison)
    end
  end
end
