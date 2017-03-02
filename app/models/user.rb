class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :children
  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :relationship, presence: true, on: :update
  validates :phone_number, presence: true, on: :update
  validates :user_type, presence: true
  validates :phone_number, presence: true
  validates :city, presence: true
  validates :state, presence: true
end
