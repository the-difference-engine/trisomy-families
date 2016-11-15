class CreateMotherComplications < ActiveRecord::Migration[5.0]
  def change
    create_table :mother_complications do |t|
      t.boolean :none
      t.boolean :gestational_diabetes
      t.boolean :preeclampsia
      t.boolean :clampsia
      t.boolean :rh_factor
      t.boolean :separated_placenta
      t.boolean :unsure
      t.boolean :extra_fluid
      t.boolean :other

      t.timestamps
    end
  end
end
