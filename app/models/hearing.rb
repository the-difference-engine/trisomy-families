class Hearing < ApplicationRecord
  has_many :health_histories
  has_many :children, through: :health_history
end
