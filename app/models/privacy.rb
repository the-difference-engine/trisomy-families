class Privacy < ApplicationRecord
  belongs_to :child
  validates :story, inclusion: { in: [true, false] }
  validates :avatar, inclusion: { in: [true, false] }
  validates :location, inclusion: { in: [true, false] }
  validates :birthday, inclusion: { in: [true, false] }
  validates :trisomy_type, inclusion: { in: [true, false] }
end
