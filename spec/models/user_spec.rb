require 'rails_helper'

RSpec.describe User, type: :model do
  context "Creates valid user" do
    user = User.new(
      first_name: "George",
      last_name: "Clooney",
      email: "#{rand(1000)}@gmail.com",
      state: "Illinois",
      city: "Chicago",
      phone_number: '6306408224',
      password: 'password',
      relationship: 'father'
    )
    user.save

    it 'is valid on save' do
      expect(user).to be_valid
    end
  end

  context "Creates an invalid user" do
    user = User.new(
      first_name: "",
      last_name: "",
      email: "",
      state: "",
      city: ""
    )

    it "is invalid without a first name" do
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end
    it "is invalid without a last name" do
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end
    it "is invalid without an email" do
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "is invalid without a state" do
      user.valid?
      expect(user.errors[:state]).to include("can't be blank")
    end
    it "is invalid without a city" do
      user.valid?
      expect(user.errors[:city]).to include("can't be blank")
    end
  end
end
