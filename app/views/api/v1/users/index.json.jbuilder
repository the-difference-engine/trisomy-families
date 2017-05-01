json.array! @users.each do |user|
  if user.id != current_user.id
    json.partial! 'user.json.jbuilder', user: user
  end
end 