class CreateRecievedTherapies < ActiveRecord::Migration[5.0]
  def change
    create_table :recieved_therapies do |t|
      t.boolean :ot 
      t.boolean :pt 
      t.boolean :dt 
      t.boolean :st
      t.boolean :dtv
      t.boolean :dth 
      t.boolean :vital_stim
      t.boolean :aquatic
      t.boolean :reflex_integration
      t.boolean :hippotherapy_equine
      t.boolean :hyperbaric
      t.string :other

      t.timestamps
    end
  end
end
