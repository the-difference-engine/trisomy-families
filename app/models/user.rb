class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :children
  has_many :families
  has_many :physicians
  
  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :relationship, presence: true, on: :update
  validates :user_type, presence: true

  def full_name
    self.first_name + " " + self.last_name
  end
end
