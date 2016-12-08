class Api::V1::FamilySerializer < ActiveModel::Serializer
  type 'family'
  attributes :id, :last_name, :address, :city, :state, :zip_code
  attribute :latitude do
      object.latitude.to_f
  end
  attribute :longitude do
    object.longitude.to_f
  end
end
