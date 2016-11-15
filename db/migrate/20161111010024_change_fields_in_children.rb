class ChangeFieldsInChildren < ActiveRecord::Migration[5.0]
  def change
    remove_column :children, :primary_diagnosis_id
    add_column :children, :primary_diagnosis, :string

    remove_column :children, :secondary_diagnosis_id
    add_column :children, :secondary_diagnosis, :string

    remove_column :children, :partial_trisomy_id
    add_column :children, :partial_trisomy, :string

  end
end
