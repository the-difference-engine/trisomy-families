json.array! @children.each do |child|
  family_id = Family.find_by(user_id: current_user.id).id
  if child.family_id == family_id
    json.id child.id
    json.first_name child.first_name
    json.last_name child.last_name
    json.nickname child.nickname
    json.picture_url child.avatar_file_name
    json.trisomy_type child.trisomy_type
  end
end