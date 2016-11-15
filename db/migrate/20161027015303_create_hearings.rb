class CreateHearings < ActiveRecord::Migration[5.0]
  def change
    create_table :hearings do |t|
      t.boolean :transient
      t.boolean :conductive
      t.boolean :nerve_loss
      t.boolean :unknown
      t.string :other

      t.timestamps
    end
  end
end
