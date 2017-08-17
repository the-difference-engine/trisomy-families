class AddFieldsToChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :secondary_mosaic_percentage, :integer
    add_column :children, :secondary_partial_trisomy, :string
  end
end
