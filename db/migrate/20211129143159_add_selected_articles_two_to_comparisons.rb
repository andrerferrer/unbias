class AddSelectedArticlesTwoToComparisons < ActiveRecord::Migration[6.0]
  def change
    add_column :comparisons, :selected_articles_two, :json
  end
end
