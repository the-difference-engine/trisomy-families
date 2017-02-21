class Physician < ApplicationRecord
  geocoded_by :full_address
  after_validation :geocode
  def full_address
    [address, city, state].compact.join(', ')
  end
  def hello
    puts "hello! I'm a doctor!"
  end
end
