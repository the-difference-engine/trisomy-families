json.array! @children.each do |child|
  json.partial! 'child.json.jbuilder', child: child
end
