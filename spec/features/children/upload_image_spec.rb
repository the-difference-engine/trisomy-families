require "rails_helper"
require 'pp'

RSpec.feature "User uploads an image", :type => :feature do
  scenario "User uploads an image" do  
    user = FactoryGirl.create(:user)

    login_as(user, :scope => :user)

    child = FactoryGirl.create(:child)

    visit "/profile/#{child.id}"

    attach_file('child[avatar]', File.absolute_path('../trisomy-families/app/assets/images/thumbs-up.jpg'))
    click_button "image-submit"

    expect(child.avatar_file_name).to eq("https://trisomy-families.s3.amazonaws.com/qejRsVmtlbnpiVuXcrWi_11529854.png")
  end
end