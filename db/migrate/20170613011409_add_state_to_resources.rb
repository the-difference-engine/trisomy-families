class AddStateToResources < ActiveRecord::Migration[5.0]
  def change
    add_column :resources, :state, :string
  end
end
