require 'rails_helper'

RSpec.describe ProfessionalCenterController, type: :controller do
  describe 'professional_center#index' do
    before(:example) {
      user = FactoryGirl.build(:user)
      user.user_type = 'admin'
      user.save
      sign_in user
    }
    it 'renders the professional center page as an admin' do
      get :index
      expect(response).to render_template('index.html.erb')
    end  
  end

  describe 'professional_center#index' do
    before(:example) {
      user = FactoryGirl.build(:user)
      user.user_type = 'doctor'
      user.save
      sign_in user
    }
    it 'renders the professional center page as an doctor' do
      get :index
      expect(response).to render_template('index.html.erb')
    end  
  end  

  describe 'professional_center#index' do
    before(:example) {
      user = FactoryGirl.build(:user)
      user.user_type = 'family'
      user.save
      sign_in user
    }
    it 'redirects to homepage if you are not an admin or doctor user type' do
      get :index
      expect(response).to redirect_to root_url
    end  
  end
end
