require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'user#home' do 
    it 'redirects to the home page' do
      get :index
      expect(response).to redirect_to root_url
    end
  end

  describe 'users#index' do 
    before(:example) {
      user = FactoryGirl.build(:user)
      user.user_type = 'admin'
      user.save
      sign_in user
    }
    it 'renders the admin index page' do
      get :index
      expect(response).to render_template('index.html.erb')
    end
  end
    
  describe 'users#children_index' do 
    before(:example) {
      user = FactoryGirl.build(:user)
      user.user_type = 'admin'
      user.save
      sign_in user
    }

    it 'renders the children index page' do
      get :children_index
      expect(response).to render_template('children_index.html.erb')
    end
  end

  describe 'user#children_index' do 
    it 'redirects to the home page' do
      get :children_index
      expect(response).to redirect_to root_url
    end
  end
end