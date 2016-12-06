class RemoveArmsAffectedFromChildren < ActiveRecord::Migration[5.0]
  def change
    remove_column :children, :arms_affected, :string
  end
end
