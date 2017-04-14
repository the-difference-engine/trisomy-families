require 'rails_helper'

RSpec.describe PhysiciansController, type: :controller do
  describe '#show' do
    before(:example) {
      user = FactoryGirl.create(:user)
      user.user_type = 'doctor'

      physician = FactoryGirl.create(:physician)
      physician.user_id = user.id
      physician.save

      user.doctor_id = physician.id
      user.save

      sign_in user
      get(:show, id: physician.id)
    }

    it 'renders the physicians show page' do
      expect(response).to render_template('show.html.erb')
    end
  end

  describe '#new' do
    before(:example) {
      user = FactoryGirl.create(:user)
      sign_in user
    }
    it 'redirects to homepage if you are not an admin or registered doctor' do
      get :new
      expect(response).to redirect_to root_url
    end
  end

  describe '#edit' do
    before(:example) {
      user = FactoryGirl.create(:user)
      physician = FactoryGirl.create(:physician)
      sign_in user
      get(:edit, id: physician.id)
    }
    it 'redirects to homepage if you are not an admin or registered doctor' do
      expect(response).to redirect_to root_url
    end
  end

  describe '#show' do
    before(:example) {
      user = FactoryGirl.create(:user)
      physician = FactoryGirl.create(:physician)
      sign_in user
      get(:show, id: physician.id)
    }
    it 'redirects to homepage if user is not admin, the actual doctor, or has no family registered' do
      expect(response).to redirect_to root_url
    end
  end
end