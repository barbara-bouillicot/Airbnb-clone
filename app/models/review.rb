class Review < ApplicationRecord
  belongs_to :booking
  has_one :user, through: :booking

  validates :comment, :rating, presence:true
  validate :max_rating

  def max_rating
    if rating > 5
      errors.add(:rating, "must be a number between 1 and 5")
    end
  end
end
