class Height < ApplicationRecord
  belongs_to :background_history
  validates :one_month, presence: true
end
