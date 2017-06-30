json.array! @physicians.each do |physician|
  json.first_name physician.first_name
  json.last_name physician.last_name
  json.address physician.address
  json.city physician.city
  json.state physician.state
  json.zip_code physician.zip_code
  json.latitude physician.latitude
  json.longitude physician.longitude
  json.website physician.website
  json.specialty physician.specialty
end
