class FavoriteListingsController < ApplicationController

  def index
    @favorite_listings = FavoriteListing.all
  end

  def create
    @favorite_listing = current_user.favorite_listings.create(favorite_listing_params)
     if favorite_listing.valid?
         render json: favorite_listing.listing, status: :created
     else
         render json: favorite_listing.errors, status: :unprocessable_entity
     end
  end

  def destroy
    render json: FavoriteListing.find_by(item_id: Listing.find(params[:id]).id, user_id: current_user.id).destroy
  end

private

  def favorite_item_params
    params.require(:favorite_listing).permit(:listing_id, :user_id)
  end

end
