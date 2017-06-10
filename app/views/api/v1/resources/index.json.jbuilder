json.array! @resources.each do |resource|
  json.id resource.id
  json.name resource.name
  json.url resource.url
  json.description resource.description
  json.image resource.image
end