class CreateEndocrines < ActiveRecord::Migration[5.0]
  def change
    create_table :endocrines do |t|
      t.boolean :hyperthyroidism
      t.boolean :hypothyroidism
      t.boolean :early_onset_pubic_hair
      t.boolean :early_onset_puberty
      t.boolean :growth_hormone_deficiency
      t.boolean :calcium_deficiency
      t.boolean :high_cortisol
      t.boolean :diabetes
      t.boolean :hypoglycemia
      t.boolean :cushings_disease
      t.boolean :vitamin_d_deficiency
      t.boolean :anemia
      t.boolean :failure_to_thrive
      t.boolean :high_blood_pressure
      t.boolean :low_blood_pressure
      t.boolean :delayed_late_puberty
      t.boolean :unsure
      t.string :other
      t.boolean :high_blood_pressure
      t.boolean :high_blood_sugar 
      t.boolean :unhealthy_cholesterol_levels 
      t.boolean :increased_abdominal_fat

      t.timestamps
    end
  end
end
