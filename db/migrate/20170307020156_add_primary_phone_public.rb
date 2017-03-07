class AddPrimaryPhonePublic < ActiveRecord::Migration[5.0]
  def change
    add_column :physicians, :primary_phone_public, :boolean
  end
end
