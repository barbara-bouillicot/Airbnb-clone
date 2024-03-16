class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @listing = Listing.find(params[:listing_id])
    @booking.total = @listing.price
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @booking = Booking.new(booking_params)
    @booking.listing = @listing
    @booking.user = current_user
    @booking.total = @listing.price
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total)
  end
end
