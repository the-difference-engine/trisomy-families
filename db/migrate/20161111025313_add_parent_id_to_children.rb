class AddParentIdToChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :parent_id, :integer
  end
end
