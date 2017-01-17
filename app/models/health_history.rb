class HealthHistory < ApplicationRecord
  has_many :children
  belongs_to :congenital_heart_defect, foreign_key: "chd_id"
  belongs_to :intestinal_issue, foreign_key: "intestinal_issues_id"
  belongs_to :gastric_surgery, foreign_key: "gastric_surgery_id"
  belongs_to :nuerological_condition, foreign_key: "nuerological_condition_id"
  belongs_to :muscular_skeletal, foreign_key: "muscular_skeletal_id"
  belongs_to :cranial_facial, foreign_key: "cranial_facial_id"
  belongs_to :endocrine, foreign_key: "endocrine_id"
  belongs_to :hearing, foreign_key: "hearing_id"
  belongs_to :vision, foreign_key: "vision_id"
  belongs_to :behavioral_health, foreign_key: "behavioral_health_id"
  belongs_to :received_therapy, foreign_key: "received_therapy_id"
  validates :offered_cardiac_surgery, presence: true
  validates :sleep_apnea, presence: true
  validates :cancer, presence: true
  validates :hearing_test, presence: true
  validates :hearing_loss_or_deaf, presence: true
  validates :hearing_loss_treatment, presence: true
  validates :highest_education, presence: true
  validates :failed_eye_exam, presence: true
  validates :in_ei, presence: true
end
