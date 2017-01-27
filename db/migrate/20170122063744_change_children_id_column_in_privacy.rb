class ChangeChildrenIdColumnInPrivacy < ActiveRecord::Migration[5.0]
  def change
    rename_column :privacies, :children_id, :child_id
  end
end
