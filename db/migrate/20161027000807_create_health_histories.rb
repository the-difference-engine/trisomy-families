class CreateHealthHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :health_histories do |t|

      t.timestamps
    end
  end
end
