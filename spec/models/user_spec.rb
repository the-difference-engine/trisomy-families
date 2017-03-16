require 'rails_helper'

RSpec.describe User, type: :model do
  context "Creates valid user" do
    user = User.new(
      first_name: "George",
      last_name: "Clooney",
      email: "#{rand(1000)}@gmail.com",
      password: 'password',
      relationship: 'father',
      user_type: 'family'
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
      email: ""
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
    it "is invalid without a user_type" do
      user.valid?
      expect(user.errors[:user_type]).to include("can't be blank")
    end
  end
end
