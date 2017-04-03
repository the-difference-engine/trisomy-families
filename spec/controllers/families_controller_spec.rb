require 'rails_helper'

RSpec.describe FamiliesController, type: :controller do
  describe '#show' do
    before(:example) {
      user = FactoryGirl.create(:user)
      sign_in user
      get(:show, params: { id: user.id })
    }

    it 'renders the show html page families page' do
      expect(response).to render_template('show.html.erb')
    end
  end

  describe '#new' do
    before(:example) {
      user = FactoryGirl.create(:user)
      sign_in user
      get(:new)
    }
    it 'renders the new family page' do
      expect(response).to render_template('new.html.erb')
    end
    before(:example) {
      user = FactoryGirl.create(:user)
      family = FactoryGirl.create(:family)
      family.user_id = user.id
      sign_in user
      get(:new)
    }
    it 'renders the family show page' do
      expect(response).to render_template('show.html.erb')
    end
  end

  describe '#create' do
    hash = { family: {
                  family_name: "Abc",
                  state: "IL",
                  city: "Chicago",
                  story: "this is a story",
                  street_address: "2148 golf court"
                  }
      }
    before(:example) {
      user = FactoryGirl.create(:user)
      sign_in user
    }
    before(:example) { post(:create, params: hash, family: { :family_name => "Fool" }) }

    it 'redirects to profile page' do
      # if you leave assert_template, it will raise an error 'NoMethodError: undefined method `matches?` for true:TrueClass
      expect(response).to redirect_to("/families/#{assigns(:family).id}")
    end
  end
 
end
