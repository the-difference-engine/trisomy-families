class RemovePrimaryDiagnosisFromFromChildren < ActiveRecord::Migration[5.0]
  def change
    remove_column :children, :primary_diagnosis, :string
  end
end
