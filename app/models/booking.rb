class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  has_many :reviews, dependent: :destroy

  validates :start_date, :end_date, :total, presence: true

  before_save :calculate_total_price


  def calculate_total_price
    total_price = (listing.price * booking_duration)
    self.total = total_price
  end

  def booking_duration
    (start_date..end_date).count
  end

  def pending?
    status == 'pending'
  end

end
