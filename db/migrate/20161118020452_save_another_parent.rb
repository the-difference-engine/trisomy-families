class SaveAnotherParent < ActiveRecord::Migration[5.0]
  def change
    add_column :parents, :first_name_2, :string
    add_column :parents, :last_name_2, :string
    add_column :parents, :city_2, :string
    add_column :parents, :state_2, :string
    add_column :parents, :phone_number_2, :string
    add_column :parents, :email_2, :string
    add_column :parents, :relationship_2, :string
  end
end
