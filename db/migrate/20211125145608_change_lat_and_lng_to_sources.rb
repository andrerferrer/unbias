class ChangeLatAndLngToSources < ActiveRecord::Migration[6.0]
  def change
    rename_column :sources, :lat, :latitude
    rename_column :sources, :lng, :longitude
  end
end
