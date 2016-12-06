class AddDiagnosesToChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :other_primary_diagnosis, :string
    add_column :children, :other_secondary_diagnosis, :string
  end
end
