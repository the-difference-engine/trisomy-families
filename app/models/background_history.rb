class BackgroundHistory < ApplicationRecord
  belongs_to :user
  validates :weight_at_birth, presence: true
  validates :height_at_birth, presence: true
  validates :head_circumference_at_birth, presence: true
  validates :delivery_method, presence: true
  validates :offered_c_section, presence: true
  validates :child_complication, presence: true
  validates :gestation_age, presence: true
  validates :mother_age_at_birth, presence: true
  validates :father_age_at_birth, presence: true
end
