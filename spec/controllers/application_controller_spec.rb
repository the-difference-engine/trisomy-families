require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'application#after_sign_in_path_for' do 
    before(:example) {
      user = FactoryGirl.create(:user)
      sign_in user
    }
    it 'redirects to family/new page' do
      expect(response).to render_template("families/new")
    end
  end

end