class ChangePhysicianSpecialitytoSpecialty < ActiveRecord::Migration[5.0]
  def change
    rename_column :physicians, :speciality, :specialty
  end
end
