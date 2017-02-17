require 'rails_helper'

RSpec.describe Physician, type: :model do
  context "Creates a valid Physician" do
    physician = Physician.new(
      first_name: "Doctor",
      last_name: "Suess",
      phone_number: "555-5555",
      address:  "1871 Merch Mart",
      city: "Chicago",
      state: "Illinois",
      zip_code: "60618",
      website: "www.google.com",
      speciality: "Heart Surgery"
    )
    physician.save

    it 'is valid on save' do
      expect(physician).to be_valid
    end
  end
end
