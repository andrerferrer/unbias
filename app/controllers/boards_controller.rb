class BoardsController < ApplicationController

  def show
    @comparisons = current_user.comparisons
  end
end
