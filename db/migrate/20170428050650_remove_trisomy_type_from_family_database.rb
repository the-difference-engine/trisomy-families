class RemoveTrisomyTypeFromFamilyDatabase < ActiveRecord::Migration[5.0]
  def change
    remove_column :families, :trisomy_type, :string
  end
end
