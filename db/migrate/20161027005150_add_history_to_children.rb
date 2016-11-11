class AddHistoryToChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :health_history_id, :integer
    add_column :children, :background_history_id, :integer
    add_column :children, :school_therapy_id, :integer

  end
end
