class Child < ApplicationRecord
  belongs_to :family
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", square: '100x100#' }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :trisomy_type, presence: true
  validates :birth_date, presence: true
  validates :trisomy_story, presence: true
  validates :private, inclusion: [true, false]
  validates :birth_order, presence: true, on: :confirm_register
  validates :parent_id, presence: true, on: :confirm_register
  validates :primary_diagnosis, presence: true, on: :confirm_register
  validates :avatar_file_name, presence: true
  belongs_to :user
  belongs_to :background_history
  belongs_to :health_history
  has_one :privacy
  has_one :contact_info_form
  accepts_nested_attributes_for :privacy

  before_validation :ensure_avatar_file_name_has_a_value, on: :create

  def current_age
    birthday = self.birth_date
    current_date = DateTime.now
    death = self.death_date
    age = (current_date.year - birthday.year) * 12 + (current_date.month - birthday.month)
    if death
      if death.year - birthday.year > 0
        age = ((death.year - birthday.year) * 12) 
        if (death.month - birthday.month) > 0
          age += (death.month - birthday.month)
        end
      else 
        age = (death.month - birthday.month)
      end
    end
    if age == 0
      age = (current_date.month - birthday.month)
    end 
    age
    
  end

  protected

  def ensure_avatar_file_name_has_a_value
    if avatar_file_name.nil?
      self.avatar_file_name = "https://trisomy-families.s3.amazonaws.com/qejRsVmtlbnpiVuXcrWi_11529854.png"
    end
  end
end
