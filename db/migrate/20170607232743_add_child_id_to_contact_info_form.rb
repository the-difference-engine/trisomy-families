class AddChildIdToContactInfoForm < ActiveRecord::Migration[5.0]
  def change
    add_column :contact_info_forms, :child_id, :integer
  end
end
