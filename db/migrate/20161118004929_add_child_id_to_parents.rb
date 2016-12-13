class AddChildIdToParents < ActiveRecord::Migration[5.0]
  def change
    add_column :parents, :child_id, :integer
  end
end
