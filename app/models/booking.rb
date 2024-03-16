class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, :end_date, :total, presence: true
end
