class Family < ApplicationRecord
  has_many :children
  belongs_to :user
  validates :website, format: {with: /(https?:\/\/)/, message: "Must include http:// or https://"}, allow_blank: true
  geocoded_by :full_address
  after_validation :geocode

  def full_address
    [street_address, city, state].compact.join(', ')
  end

  def hello
    puts "hello! I'm a family!"
  end
end
