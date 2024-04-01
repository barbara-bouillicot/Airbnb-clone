class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :favorite_listing, dependent: :destroy
  has_many :reviews, through: :bookings, dependent: :destroy
  has_many_attached :photos

  geocoded_by :address, language: :en
  after_validation :geocode, if: :will_save_change_to_address?


  validates :name, :address, :availability_from, :availability_to, :maximum_pets, :home_type, :price, :photos, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name_address_and_home_type,
  against: [ :name, :address, :home_type ],
  using: {
    tsearch: { prefix: true }
  }

  def average_rating(listing)
    if listing.reviews.present?
      total_rating = listing.reviews.sum(:rating)
      total_reviews = listing.reviews.count
      total_rating / total_reviews.to_f
    else
      0
    end
  end

  def location_by_city
    address = self.address.split(",")
    "#{address.first}, #{address.last}"
  end
end
