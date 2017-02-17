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

    expect(page.current_path).to eq "/admin-dashboard"
  end

  scenario "User is a family" do
    visit "/users/sign_up"

    fill_in "user_first_name", :with => "Michael"
    fill_in "user_last_name", :with => "Jordan"
    fill_in "user_city", :with => "Chicago"
    select "Illinois", :from => "user_state"
    fill_in "user_phone_number", :with => "(312)312-7773"
    choose 'user_user_type_family'
    fill_in "user_email", :with => "mj@gmail.com"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    find('input[name="commit"]').click

    expect(page.current_path).to eq '/profile/new'
  end

  scenario "User is a physician" do
    visit "/users/sign_up"

    fill_in "user_first_name", :with => "Scottie"
    fill_in "user_last_name", :with => "Pippen"
    fill_in "user_city", :with => "Chicago"
    select "Illinois", :from => "user_state"
    fill_in "user_phone_number", :with => "(312)312-7773"
    choose 'user_user_type_doctor'
    fill_in "user_email", :with => "sp@gmail.com"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    find('input[name="commit"]').click

    expect(page.current_path).to eq '/profile_doctor'
  end
end