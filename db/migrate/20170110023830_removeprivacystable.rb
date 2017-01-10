class Removeprivacystable < ActiveRecord::Migration[5.0]
  def change
	drop_table :privacys
  end
end
