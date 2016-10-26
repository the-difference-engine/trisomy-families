class AddSecondaryDiagnosisIdToChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :secondary_diagnosis_id, :integer
  end
end
