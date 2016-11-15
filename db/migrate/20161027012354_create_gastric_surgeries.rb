class CreateGastricSurgeries < ActiveRecord::Migration[5.0]
  def change
    create_table :gastric_surgeries do |t|
      t.boolean :repair_of_duodenal_atresia_stenosis_web
      t.boolean :repair_of_anal_stenosis_atresia
      t.boolean :gastrostomy_tube_placement
      t.boolean :surgery_for_hirschsprung_disease
      t.boolean :fundoplication_nissen_wrap
      t.boolean :none
      t.string :other
      t.timestamps
    end
  end
end
