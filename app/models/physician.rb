class Physician < ApplicationRecord
  
  geocoded_by :full_address
  after_validation :geocode

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true
  validates :speciality, presence: true

  def full_address
    [address, city, state].compact.join(', ')
  end

  def hello
    puts "hello! I'm a doctor!"
  end
end
