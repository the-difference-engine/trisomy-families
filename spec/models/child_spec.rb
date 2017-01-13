require 'rails_helper'

RSpec.describe Child, type: :model do
  
  context "Creates valid child" do
    child = Child.new(
      first_name: "George", 
      last_name: "Clooney", 
      trisomy_type: "2", 
      birth_date: "12/08/1983", 
      state: "Illinois",
      city: "Chicago",
      trisomy_story: "hello",
      private: "false"
    )
    
    it "is valid with a first name, last name, trisomy type, 
    date of birth, state, city story and display preference" do
      expect(child).to be_valid
    end
  end

  

  context "Creates an invalid child" do
    child = Child.new(
      first_name: "", 
      last_name: "", 
      trisomy_type: "",
      birth_date: "", 
      state: "",
      city: "",
      trisomy_story: "",
      private: nil
    )
    
    it "is invalid without a first name" do
      child.valid?
      expect(child.errors[:first_name]).to include("can't be blank")
    end
    it "is invalid without a last name" do
      child.valid?
      expect(child.errors[:last_name]).to include("can't be blank")
    end
    it "is invalid without a trisomy type" do
      child.valid?
      expect(child.errors[:trisomy_type]).to include("can't be blank")
    end
    it "is invalid without a birth date" do
      child.valid?
      expect(child.errors[:birth_date]).to include("can't be blank")
    end
    it "is invalid without a state" do
      child.valid?
      expect(child.errors[:state]).to include("can't be blank")
    end
    it "is invalid without a city" do
      child.valid?
      expect(child.errors[:city]).to include("can't be blank")
    end
    it "is invalid without a story" do
      child.valid?
      expect(child.errors[:trisomy_story]).to include("can't be blank")
    end
    it "is invalid without private radio button checked" do
      child.valid?
      expect(child.errors[:private]).to include("is not included in the list")
    end

  end

end
