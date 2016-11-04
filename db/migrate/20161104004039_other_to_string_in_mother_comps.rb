class OtherToStringInMotherComps < ActiveRecord::Migration[5.0]
  def change
    change_column :mother_complications, :other, :string
  end
end
