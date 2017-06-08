class CreateContactInfoForms < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_info_forms do |t|
      t.string :contact_first_name
      t.string :contact_last_name
      t.string :contact_email
      t.string :contact_phone
      t.string :parent_first_name
      t.string :parent_last_name
      t.string :parent_email
      t.string :parent_phone
      t.string :relationship
      t.text :other_info

      t.timestamps
    end
  end
end
