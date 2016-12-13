require_relative '20161130025737_add_physician_table'

class RemovePhysicianTable < ActiveRecord::Migration[5.0]
  def change
    revert AddPhysicianTable
  end
end
