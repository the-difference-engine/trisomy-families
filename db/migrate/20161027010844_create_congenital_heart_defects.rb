class CreateCongenitalHeartDefects < ActiveRecord::Migration[5.0]
  def change
    create_table :congenital_heart_defects do |t|
      t.boolean :asd
      t.boolean :vsd
      t.boolean :pda
      t.boolean :av_canal_defect
      t.boolean :dorv
      t.boolean :tof
      t.boolean :pfo
      t.string :other
      t.boolean :not_applicable

      t.timestamps
    end
  end
end
