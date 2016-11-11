class AddHearingIdToHealthHistories < ActiveRecord::Migration[5.0]
  def change
    add_column :health_histories, :hearing_id, :integer
  end
end
