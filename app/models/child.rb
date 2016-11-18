class Child < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates :first_name, :last_name, :trisomy_type, :birth_date, :state, :city, :trisomy_story, :presence => true
  validates :private, inclusion: [true, false]
  belongs_to :user
end
