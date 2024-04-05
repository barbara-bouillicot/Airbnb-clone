class User < ApplicationRecord
  has_many :bookings
  has_many :reviews, through: :bookings
  has_many :favorite_listings, dependent: :destroy
  has_many :listings
  has_many :listings, through: :favorite_listings
  has_one_attached :profile_picture
  has_many_attached :pet_pictures
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :password, :address, presence: true
  validates :email, presence: true
  validates :bio, length: { in: 20..200 }

  def location_by_city
    address = self.address.split(",")
    "#{address.first}, #{address.last}"
  end
end
