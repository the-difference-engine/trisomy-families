class AddContactInfoIdToChild < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :contact_info_id, :integer
  end
end
