class Api::V1::FamilySerializer < ActiveModel::Serializer
  type 'family'
  attributes :id, :family_name, :street_address, :city, :state

  attribute :latitude do
    if !object.latitude.nil?
      object.latitude.to_f
    end
  end
  attribute :longitude do
    if !object.longitude.nil?
      object.longitude.to_f
    end
  end

  attribute :self_url
  def self_url
    "/families/#{object.id}"
  end
end
