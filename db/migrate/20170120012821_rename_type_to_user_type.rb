class RenameTypeToUserType < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :type, :user_type
  end
end
