class HealthHistory < ApplicationRecord
  belongs_to :user
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
