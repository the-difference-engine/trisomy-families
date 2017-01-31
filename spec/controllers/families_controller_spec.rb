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
end
