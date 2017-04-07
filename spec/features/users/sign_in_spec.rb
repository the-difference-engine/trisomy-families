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

    scenario "as family without a family profile" do
        user = FactoryGirl.build(:user)
        user.user_type = "family"
        user.save

        visit "/users/sign_in"

        fill_in "inputEmail", :with => user.email
        fill_in "inputPassword", :with => user.password
        find('button[name="commit"]').click

        expect(page.current_path).to eq "/families/new"
    end

end
