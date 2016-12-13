class AddLocationToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :family_name, :string
    add_column :users, :address, :string
    add_column :users, :state, :string
    add_column :users, :city, :string
    add_column :users, :zip_code, :string
  end
end
