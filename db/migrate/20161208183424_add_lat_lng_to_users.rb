class AddLatLngToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :latitude, :decimal, :precision => 13, :scale => 10
    add_column :users, :longitude, :decimal, :precision => 13, :scale => 10
  end
end
