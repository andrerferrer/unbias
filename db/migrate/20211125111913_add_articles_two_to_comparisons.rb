class AddArticlesTwoToComparisons < ActiveRecord::Migration[6.0]
  def change
    add_column :comparisons, :articles_two, :json
  end
end
