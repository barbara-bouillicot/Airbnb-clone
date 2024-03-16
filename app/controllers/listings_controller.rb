class ListingsController < ApplicationController
  before_action :set_listing, only:[:show,:edit,:update,:destroy]

 def index
  @listings = Listing.all
 end

 def show
 end

 def new
  @listing = Listing.new
 end

 def create
  @listing = Listing.new(listing_params)
  @listing.user = current_user
  if @listing.save
    redirect_to listings_path
  else
    render :new, status: :unprocessable_entity
  end
 end

 def edit
 end

 def update
  @listing.update(listing_params)
  redirect_to listing_path(@listing)
 end

 def destroy
  @listing.destroy
  redirect_to listings_path, status: :see_other
 end

private

 def set_listing
  @listing = Listing.find(params[:id])
 end

 def listing_params
  params.require(:listing).permit(:name, :address, :availability_from, :availability_to, :maximum_pets, :home_type, :price)
 end
end
