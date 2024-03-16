class User < ApplicationRecord
  has_many :bookings
  has_many :listings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :pet_name, :password, :address, presence: true
  validates :email, presence: true
end
