class Parent < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :email, presence: true
  validates :relationship, presence: true
  validates :first_name_2, presence: true
  validates :last_name_2, presence: true
  validates :city_2, presence: true
  validates :state_2, presence: true
  validates :email_2, presence: true
  validates :relationship_2, presence: true
end
