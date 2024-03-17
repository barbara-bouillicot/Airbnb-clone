class FavoriteListing < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :listing_id, uniqueness: { scope: [:user_id], message: 'listing is already in the favorites' }
end
