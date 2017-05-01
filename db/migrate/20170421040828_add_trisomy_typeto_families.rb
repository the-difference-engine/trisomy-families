class AddTrisomyTypetoFamilies < ActiveRecord::Migration[5.0]
  def change
    add_column :families, :trisomy_type, :string
  end
end
