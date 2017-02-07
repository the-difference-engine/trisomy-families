require 'rails_helper'

RSpec.describe Parent, type: :model do
  context "Creates valid parent" do
    parent = Parent.new(
      first_name: "George",
      last_name: "Clooney",
      email: "batman@gmail.com",
      state: "Illinois",
      city: "Chicago",
      relationship: "father"
    )
    parent.save

    it 'is valid on save' do
      expect(parent).to be_valid
    end
  end

  context "Creates an invalid parent" do
    parent = Parent.new(
      first_name: "",
      last_name: "",
      email: "",
      state: "",
      city: "",
      relationship: ""
    )

    it "is invalid without a first name" do
      parent.valid?
      expect(parent.errors[:first_name]).to include("can't be blank")
    end
    it "is invalid without a last name" do
      parent.valid?
      expect(parent.errors[:last_name]).to include("can't be blank")
    end
    it "is invalid without an email" do
      parent.valid?
      expect(parent.errors[:email]).to include("can't be blank")
    end
    it "is invalid without a state" do
      parent.valid?
      expect(parent.errors[:state]).to include("can't be blank")
    end
    it "is invalid without a city" do
      parent.valid?
      expect(parent.errors[:city]).to include("can't be blank")
    end
    it "is invalid without a relationship" do
      parent.valid?
      expect(parent.errors[:relationship]).to include("can't be blank")
    end
  end
end


