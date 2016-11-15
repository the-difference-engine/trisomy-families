class RemoveSecondaryDiagnosisFromChildren < ActiveRecord::Migration[5.0]
  def change
    remove_column :children, :secondary_diagnosis, :string
  end
end
