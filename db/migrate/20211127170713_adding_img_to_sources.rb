class AddingImgToSources < ActiveRecord::Migration[6.0]
  def change
    add_column :sources, :img, :string
  end
end
