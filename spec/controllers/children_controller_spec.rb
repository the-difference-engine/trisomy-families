require 'rails_helper'

RSpec.describe ChildrenController, type: :controller do
  describe '#new_profile' do
    before(:example) {
      user = FactoryGirl.create(:user)
      sign_in user
    }
    before(:example) { get(:new_profile) }

    it 'renders the template, if logged in' do
      expect(response).to render_template('children/new_profile.html.erb')
    end

  end

  describe '#create_profile' do
    hash = { child: {
                  first_name: "Abc",
                  last_name: "Def",
                  trisomy_type: "1",
                  state: "IL",
                  city: "Chicago",
                  trisomy_story: "Lorem",
                  birth_date: "2017-01-01",
                  nickname: "Ipsom",
                  birth_order: "1",
                  primary_diagnosis: "Full",
                  other_primary_diagnosis: "B",
                  privacy_attributes: {
                    avatar: true,
                    birthday: false,
                    trisomy_type: true,
                    story: false,
                    location: true
                  }
      }
    }

    before(:example) {
      user = FactoryGirl.create(:user)
      sign_in user
    }
    before(:example) { post(:create_profile, params: hash, child: { :first_name => "Foo" }) }

    it 'redirects to profile page' do
      # if you leave assert_template, it will raise an error 'NoMethodError: undefined method `matches?` for true:TrueClass
      expect(response).to redirect_to("/profile/#{assigns(:child).id}")
    end
  end
end
