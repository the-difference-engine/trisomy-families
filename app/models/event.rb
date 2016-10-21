class Event < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true, allow_blank: true
end
