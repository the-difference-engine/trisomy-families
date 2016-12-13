class CreatePhysicians < ActiveRecord::Migration[5.0]
  def change
    create_table :physicians do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :website
      t.string :speciality

      t.timestamps
    end
  end
end
