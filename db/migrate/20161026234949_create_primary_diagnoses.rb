class CreatePrimaryDiagnoses < ActiveRecord::Migration[5.0]
  def change
    create_table :primary_diagnoses do |t|
      t.boolean :full
      t.boolean :partial
      t.boolean :mosaic
      t.boolean :balanced_translocation
      t.boolean :unbalanced_translocation
      t.boolean :ring
      t.string :other

      t.timestamps
    end
  end
end
