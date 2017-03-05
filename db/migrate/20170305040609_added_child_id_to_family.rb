class AddedChildIdToFamily < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :child_id, :integer
  end
end
