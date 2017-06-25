json.array! @physicians.each do |physician|
  json.first_name physician.first_name
  json.last_name physician.last_name
  json.specialty physician.specialty
end
