require 'rails_helper'

RSpec.describe Event, type: :model do
  
  context "Creates a valid event" do
    event = Event.create(
      title: "December Event", 
      description: "This is an event.", 
      location: "1600 Pennsylvania Ave NW, Washington, DC 20500", 
      start: "2016-12-16 19:00:00", 
      end: "2016-12-16 20:00:00",
      event_type: "Personal",
      allDay: false
    )
    
    it "is valid with title, description, start, end, event type, all day, and location" do
      expect(event).to be_valid
    end  
  end

  context "Creates an invalid event" do

    event = Event.create(
      title: "", 
      description: "", 
      location: "", 
      start: "", 
      end: "",
      event_type: "",
      allDay: nil
    )
    
    it "is invalid without a title" do
      event.valid?
      expect(event.errors[:title]).to include("can't be blank")
    end
    it "is invalid without a description" do
      event.valid?
      expect(event.errors[:description]).to include("can't be blank")
    end
    it "is invalid without a location" do
      event.valid?
      expect(event.errors[:location]).to include("can't be blank")
    end
    it "is invalid without a start" do
      event.valid?
      expect(event.errors[:start]).to include("can't be blank")
    end
    it "is invalid without an end" do
      event.valid?
      expect(event.errors[:end]).to include("can't be blank")
    end
    it "is invalid without an event_type" do
      event.valid?
      expect(event.errors[:event_type]).to include("can't be blank")
    end
    it "is invalid without an allDay" do
      event.valid?
      expect(event.errors[:allDay]).to include("is not included in the list")
    end
  end
end
