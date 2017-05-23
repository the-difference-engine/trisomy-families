json.array! @birth_order_hash.each do |order, number|
  json.partial! 'birth_order.json.jbuilder', order: order, number: number
end
