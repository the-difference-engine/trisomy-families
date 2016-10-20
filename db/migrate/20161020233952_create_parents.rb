class CreateParents < ActiveRecord::Migration[5.0]
  def change
    create_table :parents do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :state
      t.string :phone_number
      t.string :email
      t.string :relationship

      t.timestamps
    end
  end
end
