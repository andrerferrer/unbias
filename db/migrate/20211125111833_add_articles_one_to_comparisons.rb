class AddArticlesOneToComparisons < ActiveRecord::Migration[6.0]
  def change
    add_column :comparisons, :articles_one, :json
  end
end
