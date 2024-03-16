class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :name, :address, :availability_from, :availability_to, :maximum_pets, :home_type, :price, presence: true
end
