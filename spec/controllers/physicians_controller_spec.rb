require 'rails_helper'

RSpec.describe PhysiciansController, type: :controller do
  describe '#show' do
    before(:example) {
      user = FactoryGirl.create(:user)
      physician = FactoryGirl.create(:physician)
      physician.user_id = user.id
      sign_in user
      get(:show, params: {id: user.id })
    }

    it 'renders the physicians show page' do
      expect(response).to render_template('show.html.erb')
    end
  end
end