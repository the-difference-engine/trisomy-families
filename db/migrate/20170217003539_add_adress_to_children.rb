class AddAdressToChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :address, :string
  end
end
