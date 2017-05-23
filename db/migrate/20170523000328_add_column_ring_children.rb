class AddColumnRingChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :ring, :boolean
  end
end
