class RemovedChildIdColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :families, :child_id, :integer
  end
end
