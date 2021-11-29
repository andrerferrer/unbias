class PagesController < ApplicationController
  def home
    @comparison = Comparison.new
  end

  def styleguide
  end

  def mission
  end
end
