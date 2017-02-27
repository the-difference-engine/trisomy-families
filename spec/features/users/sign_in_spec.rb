require "rails_helper"
require 'pp'

RSpec.feature "User signs in", :type => :feature do
  scenario "as admin" do
    user = FactoryGirl.build(:user)

    user.user_type = 'admin'

    user.save

    visit "/users/sign_in"

    fill_in "inputEmail", :with => user.email
    fill_in "inputPassword", :with => user.password
    find('button[name="commit"]').click

    current_path.should == "/admin-dashboard"
  end

  scenario "not as admin" do
    user = FactoryGirl.create(:user)

    visit "/users/sign_in"

    fill_in "inputEmail", :with => user.email
    fill_in "inputPassword", :with => user.password
    find('button[name="commit"]').click

    current_path.should_not == "/admin-dashboard"
  end
end
