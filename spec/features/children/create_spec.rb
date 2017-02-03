require "rails_helper"
require 'pp'

RSpec.feature "User creates a profile", :type => :feature do
  scenario "User creates a profile" do  
    user = FactoryGirl.create(:user)

    login_as(user, :scope => :user)

    visit "/profile/new"

    fill_in "child_first_name", :with => "Johnny"
    fill_in "child_last_name", :with => "Rocket"
    fill_in "child_birth_date", :with => "12/08/1983"
    fill_in "child_death_date", :with => "12/08/2015"
    fill_in "child_city", :with => "Chicago"
    fill_in "child_trisomy_story", :with => "hello"
    page.choose("child_privacy_attributes_avatar_true")
    page.choose("child_privacy_attributes_birthday_true")
    page.choose("child_privacy_attributes_trisomy_type_true")
    page.choose("child_privacy_attributes_story_true")
    page.choose("child_privacy_attributes_location_true")
    click_button "Create"

    expect(page).to have_text("Johnny Rocket")
  end
end