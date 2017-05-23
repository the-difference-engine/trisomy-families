class DeleteColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :children, :full, :boolean
    remove_column :children, :partial, :boolean
    remove_column :children, :mosaic, :boolean
    remove_column :children, :unbalanced_translocation, :boolean
    remove_column :children, :balanced_translocation, :boolean
    remove_column :children, :ring, :boolean
  end
end
