class AddColumnsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :start_time, :datetime
    add_column :events, :end_time, :datetime
    add_column :events, :type, :string
    add_column :events, :allDay, :boolean
    add_column :events, :location, :string
    remove_column :events, :date, :datetime
  end
end
