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

    expect(page.current_path).to eq "/admin-dashboard"
  end


  scenario "User is a family" do
    visit "/users/sign_up"

    fill_in "first_name", :with => "Michael"
    fill_in "last_name", :with => "Jordan"
    fill_in "city", :with => "Chicago"
    select "Illinois", :from => "state"
    fill_in "phone_number", :with => "(312)312-7773"
    choose 'user_user_type_family'
    fill_in "email", :with => "mj@gmail.com"
    fill_in "password", :with => "password"
    fill_in "password_confirmation", :with => "password"
    find('input[name="commit"]').click

    expect(page.current_path).to eq '/profile/new'
  end

  scenario "User is a physician" do
    visit "/users/sign_up"

    fill_in "first_name", :with => "Scottie"
    fill_in "last_name", :with => "Pippen"
    fill_in "city", :with => "Chicago"
    select "Illinois", :from => "state"
    fill_in "phone_number", :with => "(312)312-7773"
    choose 'user_user_type_doctor'
    fill_in "email", :with => "sp@gmail.com"
    fill_in "password", :with => "password"
    fill_in "password_confirmation", :with => "password"
    find('input[name="commit"]').click

    expect(page.current_path).to eq '/profile_doctor'
  end
end
