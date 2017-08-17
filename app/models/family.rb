class Family < ApplicationRecord
  has_many :children
  belongs_to :user
  validates :website, format: {with: /(https?:\/\/)/, message: "Must include http:// or https://"}, allow_blank: true
  validates :family_name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :story, presence: true
  geocoded_by :full_address
  after_validation :geocode

  def full_address
    [street_address, city, state].compact.join(', ')
  end

  def hello
    puts "hello! I'm a family!"
  end
end
