class CreateCranialFacials < ActiveRecord::Migration[5.0]
  def change
    create_table :cranial_facials do |t|
      t.boolean :cranial_deformities
      t.boolean :cleft_palate
      t.boolean :cleft_lip
      t.boolean :high_arch
      t.boolean :low_set_ears
      t.boolean :wide_spaced_eyes
      t.boolean :wild_eyebrows
      t.boolean :extraordinarily_long_eyelashes
      t.boolean :overgrowth_of_gums
      t.boolean :delayed_teething

      t.timestamps
    end
  end
end
