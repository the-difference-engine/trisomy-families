class AddPurposeToResources < ActiveRecord::Migration[5.0]
  def change
    add_column :resources, :purpose, :string
  end
end
