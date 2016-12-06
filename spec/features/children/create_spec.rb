require "rails_helper"

RSpec.feature "User creates a profile", :type => :feature do
  scenario "User creates a profile" do  
    user = FactoryGirl.create(:user)
    user.save

    login_as(user, :scope => :user)

    visit "/profile/new"

    fill_in "first_name", :with => "Johnny"
    fill_in "last_name", :with => "Rocket"
    fill_in "date_of_birth", :with => "12/08/1983"
    fill_in "date_of_death", :with => "12/08/2015"
    fill_in "city", :with => "Chicago"
    fill_in "trisomy_story", :with => "hello"
    page.choose("private_false")
    click_button "Save changes"

    expect(page).to have_text("Johnny Rocket")
  end
end