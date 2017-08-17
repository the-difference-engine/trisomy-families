json.id child.id
json.first_name child.first_name
json.last_name child.last_name
json.full_name child.first_name + " " + child.last_name
json.trisomy_type child.trisomy_type
json.birth_date child.birth_date
json.death_date child.death_date
json.avatar child.avatar_file_name
json.city child.city
json.state child.state
json.birth_order child.birth_order
json.accepted child.accepted
json.registered child.registered
json.privacy child.privacy
if child.privacy != nil
  json.privacy_count child.privacy.attributes.values[2..-3].select {|value| value == false}.count
end