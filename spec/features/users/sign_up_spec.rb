require "rails_helper"
require 'pp'

RSpec.feature "User signs up", :type => :feature do

  scenario "as family member" do
    visit "/users/sign_up"

    fill_in "first_name", :with => "Michael"
    fill_in "last_name", :with => "Jordan"
    choose 'user_user_type_family'
    fill_in "email", :with => "mj@gmail.com"
    fill_in "password", :with => "password"
    fill_in "password_confirmation", :with => "password"
    find('input[name="commit"]').click

    expect(page.current_path).to eq '/families/new'
  end

  scenario "as a physician" do
        visit "/users/sign_up"

        fill_in "first_name", :with => "Scottie"
        fill_in "last_name", :with => "Pippen"
        choose 'user_user_type_doctor'
        fill_in "email", :with => "sp@gmail.com"
        fill_in "password", :with => "password"
        fill_in "password_confirmation", :with => "password"
        find('input[name="commit"]').click

        expect(page.current_path).to eq '/physicians/new'
    end

end