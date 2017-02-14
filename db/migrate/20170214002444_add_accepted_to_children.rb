class AddAcceptedToChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :accepted, :boolean
  end
end
