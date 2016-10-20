json.array!(@events) do |event|
  json.extract! event, :title, :description
  json.start event.start_time
  json.end event.end_time
end
