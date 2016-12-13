class Api::V1::UserSerializer < ActiveModel::Serializer
  type 'user'
  attributes :id, :last_name, :address, :state, :city, :zip_code
end
