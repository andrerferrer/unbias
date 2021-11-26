class ChangeDataTypeCoordinates < ActiveRecord::Migration[6.0]
  def change
    change_column :sources, :latitude, :float
    change_column :sources, :longitude, :float
  end
end
