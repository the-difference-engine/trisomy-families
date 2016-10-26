class ChangeColumnInEvents < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :start_time, :start
    rename_column :events, :end_time, :end

  end
end
