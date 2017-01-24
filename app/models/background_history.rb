class BackgroundHistory < ApplicationRecord
  has_many :children
  belongs_to :weight, foreign_key: "weight_id"
  belongs_to :height, foreign_key: "height_id"
  belongs_to :head_circumference, foreign_key: "head_circumference_id"
  belongs_to :mother_complication, foreign_key: "mother_complication_id"
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
