class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  has_many :reviews, dependent: :destroy

  validates :start_date, :end_date, :total, :number_of_pets, presence: true
  validate :validate_number_of_pets

  before_save :calculate_total_price


  def calculate_total_price
    total_price = (listing.price * booking_duration * self.number_of_pets)
    self.total = total_price
  end

  def booking_duration
    (start_date...end_date).count
  end

  def pending?
    status == 'pending'
  end

  def validate_number_of_pets
    if number_of_pets > listing.maximum_pets
      errors.add(:number_of_pets, "cannot exceed the maximum allowed for this listing")
    end
  end
end
