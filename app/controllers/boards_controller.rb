class BoardsController < ApplicationController
  def show
    @comparisons_all = current_user.comparisons
    @comparisons = @comparisons_all.select do |comparison|
      comparison.articles_one.present?
    end
  end
end
