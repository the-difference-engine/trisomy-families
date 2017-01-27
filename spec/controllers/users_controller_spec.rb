require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it 'redirects to the home page' do
    get :index
    expect(response).to redirect_to root_url
  end

  describe 'users#index'
  before(:example) {
    admin = FactoryGirl.create(:admin)
    sign_in admin
  }
  it 'renders the admin index page' do
    get :index
    expect(response).to render_template('index.html.erb')
  end
end