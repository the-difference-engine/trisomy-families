

@children = Child.where(family_id: family.id)
@child_types = []
if @children != nil
  @children.each do |child|
    @child_types << child.trisomy_type
    json.children @child_types
  end
end
json.latitude family.latitude
json.longitude family.longitude
json.city family.city
json.state family.state
json.family_name family.family_name
json.street_address family.street_address
json.id family.id
