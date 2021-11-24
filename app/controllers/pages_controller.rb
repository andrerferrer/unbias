class PagesController < ApplicationController
  def home
    @comparison = Comparison.new
  end

  def styleguide
  end
end
