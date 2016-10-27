class CreateHeights < ActiveRecord::Migration[5.0]
  def change
    create_table :heights do |t|
      t.decimal :one_month
      t.decimal :two_month
      t.decimal :three_month
      t.decimal :four_month
      t.decimal :five_month
      t.decimal :six_month
      t.decimal :one_year
      t.decimal :eighteen_month
      t.decimal :two_year
      t.decimal :three_year
      t.decimal :four_year
      t.decimal :five_year
      t.decimal :six_year
      t.decimal :seven_year
      t.decimal :eight_year
      t.decimal :nine_year
      t.decimal :ten_year
      t.decimal :eleven_year
      t.decimal :twelve_year
      t.decimal :thirteen_year
      t.decimal :fourteen_year
      t.decimal :fifteen_year
      t.decimal :sixteen_year
      t.decimal :seventeen_year
      t.decimal :eighteen_year
      t.decimal :nineteen_year
      t.decimal :twenty_year
      t.decimal :twentyone_year
      t.decimal :twentytwo_year
      t.decimal :twentythree_year
      t.decimal :twentyfour_year
      t.decimal :twentyfive_year
      t.decimal :twentysix_year
      t.decimal :twentyseven_year
      t.decimal :twentyeight_year
      t.decimal :twentynine_year
      t.decimal :thirty_year
      t.decimal :thirtyone_year
      t.decimal :thirtytwo_year
      t.decimal :thirtythree_year
      t.decimal :thirtyfour_year
      t.decimal :thirtyfive_year
      t.decimal :thirtysix_year
      t.decimal :thirtyseven_year
      t.decimal :thirtyeight_year
      t.decimal :thirtynine_year
      t.decimal :forty_year

      t.timestamps
    end
  end
end
