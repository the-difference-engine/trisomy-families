class AddPrimaryDiagnosisIdToChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :primary_diagnosis_id, :integer
  end
end
