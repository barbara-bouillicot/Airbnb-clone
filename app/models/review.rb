class Review < ApplicationRecord
  belongs_to :booking

  validates :comment, :rating, presence:true
end
