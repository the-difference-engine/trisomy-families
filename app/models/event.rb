class Event < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true, allow_blank: true
  validates :date, presence: true
end
