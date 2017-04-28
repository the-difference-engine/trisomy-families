json.array! @families.each do |family|
  json.partial! 'family.json.jbuilder', family: family
end
