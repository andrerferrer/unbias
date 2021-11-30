class AddSentimentToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :sentiment, :float
  end
end
