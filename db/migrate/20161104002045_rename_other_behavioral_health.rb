class RenameOtherBehavioralHealth < ActiveRecord::Migration[5.0]
  def change
    rename_column :behavioral_healths, :other, :other_diagnosis
    add_column :behavioral_healths, :other_delay, :string
  end
end
