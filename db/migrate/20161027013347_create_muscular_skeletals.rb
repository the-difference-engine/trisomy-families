class CreateMuscularSkeletals < ActiveRecord::Migration[5.0]
  def change
    create_table :muscular_skeletals do |t|
      t.boolean :atlanto_axial_instability
      t.boolean :cervical_spine_degeneration 
      t.boolean :osteopenia
      t.boolean :osteoporosis
      t.boolean :fractures
      t.boolean :scoliosis
      t.boolean :lordosis
      t.boolean :kyphosis
      t.boolean :hand_bone_missing
      t.boolean :leg_bone_missing
      t.boolean :rib_deformities
      t.boolean :club_foot
      t.boolean :rocker_bottom_feet
      t.boolean :atlanto_axial_instability_surgery
      t.boolean :cervical_spine_degeneration_surgery
      t.boolean :osteopenia_surgery
      t.boolean :osteoporosis_surgery
      t.boolean :fractures_surgery
      t.boolean :scoliosis_surgery
      t.boolean :lordosis_surgery
      t.boolean :kyphosis_surgery
      t.boolean :hand_bone_missing_surgery
      t.boolean :leg_bone_missing_surgery
      t.boolean :rib_deformities_surgery
      t.boolean :club_foot_surgery
      t.boolean :rocker_bottom_feet_surgery

      t.timestamps
    end
  end
end
