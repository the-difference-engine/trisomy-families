json.array!(@events) do |event|
  json.extract! event, :title, :description
  json.start event.start
  json.end event.end
end
