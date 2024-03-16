class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?


  validates :name, :address, :availability_from, :availability_to, :maximum_pets, :home_type, :price, :photos, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name_address_and_home_type,
  against: [ :name, :address, :home_type ],
  using: {
    tsearch: { prefix: true }
  }
end
