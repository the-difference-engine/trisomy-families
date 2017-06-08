class AddWebsiteToFamily < ActiveRecord::Migration[5.0]
  def change
    add_column :families, :website, :string
  end
end
