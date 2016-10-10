require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'POST #create' do
    subject { post :create, { :event => { :title => 'Event Title', :description => 'Event Descriptions', :date => '2016-10-16' } } }

    it 'redirects to homepage' do
      expect(subject).to redirect_to('/')
    end
  end
end
