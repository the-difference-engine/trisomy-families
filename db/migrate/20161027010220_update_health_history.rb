class UpdateHealthHistory < ActiveRecord::Migration[5.0]
  def change
    add_column :health_histories, :chd, :boolean
    add_column :health_histories, :chd_id, :integer
    add_column :health_histories, :offered_cardiac_surgery, :string
    add_column :health_histories, :first_cardiac_surgery_age, :integer
    add_column :health_histories, :first_cardiac_surgery_successful, :string
    add_column :health_histories, :multiple_cardiac_surgeries, :boolean
    add_column :health_histories, :intestinal_issues_id, :integer
    add_column :health_histories, :gastric_surgery_id, :integer
    add_column :health_histories, :seizure_epilepsy, :boolean
    add_column :health_histories, :nuerological_condition_id, :integer
    add_column :health_histories, :muscular_skeletal_id, :integer
    add_column :health_histories, :sleep_apnea, :string
    add_column :health_histories, :cranial_facial_id, :integer
    add_column :health_histories, :cancer, :string
    add_column :health_histories, :endocrine_id, :integer
    add_column :health_histories, :metabolic_syndrome, :boolean
    add_column :health_histories, :hearing_test, :string
    add_column :health_histories, :had_an_abr, :boolean
    add_column :health_histories, :hearing_loss_or_deaf, :string
    add_column :health_histories, :hearing_loss_treatment, :string
    add_column :health_histories, :failed_eye_exam, :string
    add_column :health_histories, :vision_id, :integer
    add_column :health_histories, :behavioral_health_id, :integer
    add_column :health_histories, :in_ei, :string
    add_column :health_histories, :attend_school, :boolean
    add_column :health_histories, :home_schooled_bound, :boolean
    add_column :health_histories, :highest_education, :string
    add_column :health_histories, :received_therapy_id, :integer
    add_column :health_histories, :background_history_id, :integer
    add_column :health_histories, :clinical_trial, :boolean
    add_column :health_histories, :clinical_trial_participation, :boolean
  end
end
