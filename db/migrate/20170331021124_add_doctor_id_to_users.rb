class AddDoctorIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :doctor_id, :integer
  end
end
