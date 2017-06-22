class AddImagesToHomePageContents < ActiveRecord::Migration[5.0]
  def change
    add_column :home_page_contents, :create_profile_image1, :string
    add_column :home_page_contents, :create_profile_image2, :string
    add_column :home_page_contents, :create_profile_image3, :string
    add_column :home_page_contents, :family_center_image, :string
    add_column :home_page_contents, :data_center_image, :string
  end
end
