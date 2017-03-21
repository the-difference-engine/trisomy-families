class AddAvatarFileNameColumnToPhysicians < ActiveRecord::Migration[5.0]
  def change
    add_column :physicians, :avatar_file_name, :string
  end
end
