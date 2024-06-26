class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings, dependent: :destroy
  has_many :favorite_listings, dependent: :destroy
  has_many :listings, dependent: :destroy

  has_one_attached :profile_picture
  has_many_attached :pet_pictures
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :address, presence: true
  validates :email, presence: true
  validates :bio, length: { in: 20..200 }

  def location_by_city
    address = self.address.split(",")
    "#{address.first}, #{address.last}"
  end
end
