class ChangeBackToSpecilaity < ActiveRecord::Migration[5.0]
  def change
    rename_column :physicians, :specialty, :speciality
  end
end
