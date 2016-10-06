class CreateChildren < ActiveRecord::Migration[5.0]
  def change
    create_table :children do |t|

      t.string :first_name
      t.string :last_name
      t.string :trisomy_type
      t.datetime :birth_date
      t.datetime :death_date
      t.string :city
      t.string :state
      t.text :trisomy_story

      t.timestamps
    end
  end
end
