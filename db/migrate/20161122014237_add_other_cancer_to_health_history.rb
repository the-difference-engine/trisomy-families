class AddOtherCancerToHealthHistory < ActiveRecord::Migration[5.0]
  def change
    add_column :health_histories, :other_cancer, :string
  end
end
