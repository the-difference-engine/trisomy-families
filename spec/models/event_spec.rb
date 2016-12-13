require 'rails_helper'

RSpec.describe Event, type: :model do
  
  context "Creates a valid event" do
    current_event_count = Event.count

    event = Event.create(
      title: "December Event", 
      description: "This is an event.", 
      location: "1600 Pennsylvania Ave NW, Washington, DC 20500", 
      start: "2016-12-16 19:00:00", 
      end: "2016-12-16 20:00:00",
      event_type: "Personal",
      allDay: false
    )
    
    it "will add an event to the database" do
      expect(Event.count).to eq(current_event_count + 1)
    end
  end

  context "Creates an invalid event" do
    current_event_count = Event.count

    event = Event.create(
      title: "", 
      description: "This is an event.", 
      location: "1600 Pennsylvania Ave NW, Washington, DC 20500", 
      start: "2016-12-16 19:00:00", 
      end: "2016-12-16 20:00:00",
      event_type: "Personal",
      allDay: false
    )
    
    it "will not add an event to the database" do
      expect(Event.count).to eq(current_event_count)
    end
  end
end
