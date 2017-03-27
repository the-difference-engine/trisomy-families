require 'rails_helper'

RSpec.describe Physician, type: :model do
  context "Creates a valid Physician" do
    physician = Physician.new(
      first_name: "Doctor",
      last_name: "Suess",
      personal_number: "555-5555",
      primary_phone_public: true,
      address:  "1871 Merch Mart",
      phone_number: "333-3333",
      city: "Chicago",
      state: "Illinois",
      zip_code: "60618",
      website: "www.google.com",
      specialty: "Heart Surgery"
    )
    physician.save

    it 'is valid on save' do
      expect(physician).to be_valid
    end
  end

  context "Creates an invalid physician" do 
    physician = Physician.new(
      first_name: "",
      last_name: "",
      phone_number: "",
      address: "",
      city: "",
      state: "",
      zip_code: "",
      website: "",
      specialty: ""
    )
    physician.save

    it "is invalid without a first name" do
      physician.valid?
      expect(physician.errors[:first_name]).to include("can't be blank")
    end
    it "is invalid without a last name" do
      physician.valid?
      expect(physician.errors[:last_name]).to include("can't be blank")
    end
    it "is invalid without a phone number" do
      physician.valid?
      expect(physician.errors[:phone_number]).to include("can't be blank")
    end
    it "is invalid without a address" do
      physician.valid?
      expect(physician.errors[:address]).to include("can't be blank")
    end
    it "is invalid without a city" do
      physician.valid?
      expect(physician.errors[:city]).to include("can't be blank")
    end
    it "is invalid without a state" do
      physician.valid?
      expect(physician.errors[:state]).to include("can't be blank")
    end
    it "is invalid without a zip code" do
      physician.valid?
      expect(physician.errors[:zip_code]).to include("can't be blank")
    end
    it "is invalid without a speciality" do
      physician.valid?
      expect(physician.errors[:specialty]).to include("can't be blank")
    end
  end
end
