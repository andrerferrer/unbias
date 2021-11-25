class AddSourceKeywordToSources < ActiveRecord::Migration[6.0]
  def change
    add_column :sources, :source_keyword, :string
  end
end
