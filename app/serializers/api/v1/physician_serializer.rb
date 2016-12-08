class Api::V1::PhysicianSerializer < ActiveModel::Serializer
  type 'physician'
  attributes :id, :first_name, :last_name, :phone_number, :address, :city, :state, :zip_code
  attribute :website, key: :link
  attribute :speciality
  attribute :latitude do
    object.latitude.to_f
  end
  attribute :longitude do
    object.longitude.to_f
  end
end
