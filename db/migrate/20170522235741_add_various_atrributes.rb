class AddVariousAtrributes < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :full, :boolean
    add_column :children, :partial, :boolean
    add_column :children, :mosaic, :boolean
    add_column :children, :balanced_translocation, :boolean
    add_column :children, :unbalanced_translocation, :boolean
  end
end
