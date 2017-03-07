class AddPersonalPhoneNumberToPhysicians < ActiveRecord::Migration[5.0]
  def change
    add_column :physicians, :personal_number, :string
  end
end
