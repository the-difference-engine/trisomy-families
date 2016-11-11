class CreateVisions < ActiveRecord::Migration[5.0]
  def change
    create_table :visions do |t|
      t.boolean :cataract
      t.boolean :strabismus
      t.boolean :lazy_eye
      t.boolean :near_sighted
      t.boolean :far_sighted
      t.boolean :cvi
      t.boolean :astigmatism
      t.boolean :ptosis
      t.boolean :blockage_of_tear_duct
      t.boolean :depth_perception_problems
      t.boolean :blindness
      t.boolean :glaucoma
      t.boolean :torn_retina
      t.boolean :detached_retina
      t.boolean :undeveloped_eyes
      t.boolean :underdeveloped_eyes
      t.boolean :undeveloped_eye_socket
      t.boolean :underdeveloped_eye_socket
      t.boolean :dry_eyes
      t.boolean :doesnt_blink_well
      t.boolean :doesnt_close_eyes_when_sleeping

      t.timestamps
    end
  end
end
