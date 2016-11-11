class AddPartialTrisomyIdToChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :partial_trisomy_id, :integer
  end
end
