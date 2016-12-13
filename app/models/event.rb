class Event < ApplicationRecord
  validates :title, :description, :start, :end, :event_type, :location, presence: true
  validates :allDay, inclusion: {in: [true, false]}
  validates :allDay, exclusion: {in: [nil]}
end
