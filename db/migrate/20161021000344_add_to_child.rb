class AddToChild < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :nickname, :string
    add_column :children, :birth_order, :integer
    add_column :children, :primary_diagnosis, :string
    add_column :children, :other_chrom_affected, :string
    add_column :children, :secondary_diagnosis, :string
    add_column :children, :mosaic_percentage, :integer
    add_column :children, :arms_affected, :string
  end
end
