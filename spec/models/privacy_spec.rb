require 'rails_helper'

RSpec.describe Privacy, type: :model do
  privacy = Privacy.new(child_id: 0,
                            story: nil,
                            avatar: nil,
                            location: nil,
                            birthday: nil,
                            trisomy_type: nil)

  it 'is invalid without a story' do
    privacy.save
    expect(privacy.errors.details[:story][0][:error]).to eq(:inclusion)
  end

  it 'is invalid without an avatar' do
    privacy.save
    expect(privacy.errors.details[:avatar][0][:error]).to eq(:inclusion)
  end

  it 'is invalid without a location' do
    privacy.save
    expect(privacy.errors.details[:location][0][:error]).to eq(:inclusion)
  end

  it 'is invalid without a birthday' do
    privacy.save
    expect(privacy.errors.details[:birthday][0][:error]).to eq(:inclusion)
  end

  it 'is invalid without a trisomy_type' do
    privacy.save
    expect(privacy.errors.details[:trisomy_type][0][:error]).to eq(:inclusion)
  end

  it 'is valid on save' do
    privacy.update_attributes(story: true,
                              avatar: false,
                              location: true,
                              birthday: false,
                              trisomy_type: true)
    expect(privacy.valid?).to eq(true)
  end
end
