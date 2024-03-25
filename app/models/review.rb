class Review < ApplicationRecord
  belongs_to :booking
  has_one :user, through: :booking

  validates :comment, :rating, presence:true
end
