json.array! @children.each do |child|
  json.id child.id
  json.first_name child.first_name
  json.nickname child.nickname
  json.trisomy_story child.trisomy_story
  json.photo child.avatar_file_name
  json.age child.current_age / 12
end