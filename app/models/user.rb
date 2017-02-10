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
<<<<<<< HEAD
  validates :phone_number, presence: true, on: :update
  validates :user_type, presence: true, on: :update
=======
  validates :phone_number, presence: true
  validates :city, presence: true
  validates :state, presence: true
>>>>>>> 72a56af17d8e62201dc94ab08523c3679d4f2e15
end
