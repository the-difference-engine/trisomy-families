class AddAttachmentAvatarToParent < ActiveRecord::Migration[5.0]
  def self.up
    change_table :parents do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :parents, :avatar
  end
end
