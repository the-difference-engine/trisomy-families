json.array! @children.each do |child|
  # json.child child
  # condition not met for me
  if child.health_history && child.background_history
    json.partial! 'child.json.jbuilder', child: child
  end
  # should have an else condition
end
