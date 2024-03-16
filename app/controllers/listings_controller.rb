class ListingsController < ApplicationController

 def index
  @listings = Listing.all
 end

 def new
  @listing = Listing.new
 end

 def create
  @listing = Listing.new(listing_params)
  @listing.save
  if @listing.save
    redirect_to root_path
  else
    render :new, status: :unprocessable_entity
  end
 end

private

 def listing_params
  params.require(:listing).permit(:name, :address, :availability_from, :availability_to, :maximum_pets, :home_type, :price)
 end
end
