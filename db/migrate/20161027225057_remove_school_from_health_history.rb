class RemoveSchoolFromHealthHistory < ActiveRecord::Migration[5.0]
  def change
    remove_column :children, :school_therapy_id, :integer
  end
end
