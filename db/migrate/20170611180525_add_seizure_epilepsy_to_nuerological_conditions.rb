class AddSeizureEpilepsyToNuerologicalConditions < ActiveRecord::Migration[5.0]
  def change
    add_column :nuerological_conditions, :seizure_epilepsy, :boolean
  end
end
