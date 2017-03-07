class ChangeNameOfChildIdToFamilyId < ActiveRecord::Migration[5.0]
  def change
    rename_column :children, :child_id, :family_id
  end
end
