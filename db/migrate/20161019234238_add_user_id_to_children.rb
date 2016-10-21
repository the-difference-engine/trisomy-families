class AddUserIdToChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :user_id, :integer
  end
end
