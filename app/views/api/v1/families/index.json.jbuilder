json.array! @families.each do |family|
  family_id = Family.find_by(user_id: current_user.id).id
  if family.id == family_id
    json.id family.id
    json.family_name family.family_name
    json.address family.street_address
    json.city family.city
    json.state family.state
    json.story family.story
    json.photo family.photo
    json.website family.website
  end
end