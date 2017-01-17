class RemovePrivacies < ActiveRecord::Migration[5.0]
  def change
    create_table :privacies do |t|
      t.integer :children_id
      t.boolean :story
      t.boolean :avatar
      t.boolean :location
      t.boolean :birthday
      t.boolean :trisomy_type

      t.timestamps
    end
  end
end
