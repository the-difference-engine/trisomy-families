class AddRegistrationToChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :registered, :boolean, default: false
  end
end
