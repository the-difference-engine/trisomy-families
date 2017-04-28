json.id user.id
if user.user_type == 'family'
  @profile = Family.find_by(user_id: user.id)
  if @profile != nil
    json.profile @profile.id
  end
elsif user.user_type == 'doctor'
  @profile = Physician.find_by(user_id: user.id) 
  if @profile != nil
    json.profile @profile.id
  end
end
json.first_name user.first_name
json.last_name user.last_name
json.email user.email
json.user_type user.user_type
json.created_at user.created_at
