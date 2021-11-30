class AddSelectedArticlesOneToComparisons < ActiveRecord::Migration[6.0]
  def change
    add_column :comparisons, :selected_articles_one, :json
  end
end
