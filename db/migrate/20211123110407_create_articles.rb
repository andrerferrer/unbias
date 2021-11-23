class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :description
      t.string :image_url
      t.string :source_url
      t.string :source_name
      t.date :published_at

      t.timestamps
    end
  end
end
