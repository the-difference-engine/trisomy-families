class CreateFamilies < ActiveRecord::Migration[5.0]
  def change
    create_table :families do |t|
      t.string :family_name
      t.string :street_address
      t.string :city
      t.string :state
      t.float :latitude
      t.float :longitude
      t.string :story
      t.string :photo

      t.timestamps
    end
  end
end
