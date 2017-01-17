json.array! @children.each do |child|
  if child.health_history && child.background_history
    json.partial! 'child.json.jbuilder', child: child
  end
end 