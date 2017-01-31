json.array! @users.each do |user|
  json.partial! 'user.json.jbuilder', user: user
end 