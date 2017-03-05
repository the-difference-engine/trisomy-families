class AddChildIdToFamilies < ActiveRecord::Migration[5.0]
  def change
    add_column :families, :child_id, :integer
  end
end
