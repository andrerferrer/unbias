class FixColumnNames < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :image_url, :image
    rename_column :articles, :source_url, :url
    rename_column :articles, :source_name, :source
  end
end
