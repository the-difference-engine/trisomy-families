require 'rails_helper'

RSpec.describe Family, type: :model do
  context "Creates a valid Family" do
    family = Family.new(
      family_name: "Smith",
      street_address:  "1871 Merch Mart",
      city: "Chicago",
      state: "Illinois",
      latitude: 47.0,
      longitude: 100.0
    )
    family.save

    it 'is valid on save' do
      expect(family).to be_valid
    end
  end
end
