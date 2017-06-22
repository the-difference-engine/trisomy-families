class Weight < ApplicationRecord
  has_many :background_histories
  has_many :children, through: :background_history
  # validates :one_month, presence: true
end
