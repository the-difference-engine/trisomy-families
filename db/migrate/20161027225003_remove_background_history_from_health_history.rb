class RemoveBackgroundHistoryFromHealthHistory < ActiveRecord::Migration[5.0]
  def change
    remove_column :health_histories, :background_history_id, :integer
  end
end
