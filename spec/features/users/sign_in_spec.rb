require "rails_helper"
require 'pp'

RSpec.feature "User signs in", :type => :feature do
  scenario "User is an admin" do  
    user = FactoryGirl.build(:user)

    user.user_type = 'admin'

    user.save

    visit "/users/sign_in"

    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    find('input[name="commit"]').click

    current_path.should == "/admin-dashboard"
  end

  scenario "User is not an admin" do 
    user = FactoryGirl.create(:user)

    visit "/users/sign_in"

    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    find('input[name="commit"]').click

    current_path.should_not == "/admin-dashboard"
  end
end