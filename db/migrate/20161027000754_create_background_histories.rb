class CreateBackgroundHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :background_histories do |t|
      t.decimal :weight_at_birth
      t.integer :height_at_birth
      t.integer :head_circumference_at_birth
      t.boolean :trisomy_relative
      t.string :delivery_method
      t.integer :weight_id
      t.integer :height_id
      t.integer :head_circumference_id
      t.integer :mother_complication_id
      t.string :offered_c_section
      t.string :child_complication
      t.string :apgar_score
      t.integer :gestation_age
      t.integer :mother_age_at_birth
      t.integer :father_age_at_birth
      t.boolean :multiple_birth
      t.boolean :multiple_birth_trisomy
      t.boolean :siblings_with_trisomy

      t.timestamps
    end
  end
end
