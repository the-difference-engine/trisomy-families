class CreatePartialTrisomies < ActiveRecord::Migration[5.0]
  def change
    create_table :partial_trisomies do |t|
      t.boolean :p
      t.boolean :q
      t.boolean :both
      t.boolean :unsure

      t.timestamps
    end
  end
end
