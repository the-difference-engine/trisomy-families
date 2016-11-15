class CreateNuerologicalConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :nuerological_conditions do |t|
      t.boolean :brain_malformation
      t.boolean :cyst
      t.boolean :cp 
      t.boolean :stroke
      t.boolean :unsure
      t.boolean :brain_malformation_surgery
      t.boolean :cyst_surgery
      t.boolean :cp_surgery 
      t.boolean :stroke_surgery
      t.string :other

      t.timestamps
    end
  end
end
