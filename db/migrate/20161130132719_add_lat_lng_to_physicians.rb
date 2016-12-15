class AddLatLngToPhysicians < ActiveRecord::Migration[5.0]
  def change
    add_column :physicians, :latitude, :decimal, :precision => 13, :scale => 10
    add_column :physicians, :longitude, :decimal, :precision => 13, :scale => 10
  end
end
