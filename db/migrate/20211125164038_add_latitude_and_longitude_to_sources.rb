class AddLatitudeAndLongitudeToSources < ActiveRecord::Migration[6.0]
  def change
    add_column :sources, :latitude, :integer
    add_column :sources, :longitude, :integer
  end
end
