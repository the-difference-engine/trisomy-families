class CreateHomePageContents < ActiveRecord::Migration[5.0]
  def change
    create_table :home_page_contents do |t|
      t.string :banner_title
      t.text :banner_text
      t.string :banner_image
      t.string :mission_title
      t.string :mission_sub_title
      t.text :mission_text
      t.string :create_profile_title
      t.text :create_profile_text
      t.string :family_center_title
      t.text :family_center_text
      t.string :data_center_title
      t.text :data_center_text
      t.string :birthday_title
      t.text :birthday_text
      t.string :company_title
      t.string :company_phone_number
      t.string :company_address

      t.timestamps
    end
  end
end
