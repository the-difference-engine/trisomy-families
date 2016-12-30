class Child < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", square: '100x100#' }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :trisomy_type, presence: true
  validates :birth_date, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :trisomy_story, presence: true
  validates :private, inclusion: [true, false]
  validates :birth_order, presence: true, on: :confirm_register
  validates :parent_id, presence: true, on: :confirm_register
  validates :primary_diagnosis, presence: true, on: :confirm_register
  belongs_to :user
end
