class FavoriteListingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @favorites = current_user.favorite_listings.includes(:listing)
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @favorite_listing = current_user.favorite_listings.new(listing: @listing)

    if @favorite_listing.save
      head :ok
    else
      render json: { errors: @favorite_listing.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @listing = Listing.find(params[:listing_id])
    @favorite_listing = current_user.favorite_listings.find_by(listing: @listing)
    if @favorite_listing
      @favorite_listing.destroy
      head :ok
    else
      head :not_found
    end
  end

  def check
    @listing = Listing.find(params[:id])
    is_favorite = current_user.favorite_listings.exists?(listing_id: @listing.id)
    render json: { isFavorite: is_favorite }
  end
end
