json.array! @trisomy_types_hash.each do |type, number|
  json.partial! 'trisomy_type.json.jbuilder', type: type, number: number
end
