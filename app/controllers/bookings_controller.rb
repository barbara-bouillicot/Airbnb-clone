class BookingsController < ApplicationController
  before_action :set_booking, only:[:show, :destroy]

  def index
    @bookings = Booking.all
    @booking_requests = current_user.listings.map do | listing|
      listing.bookings
    end.flatten
  end

  def show
    @booking = Booking.find(params[:id])
    @reviews = @booking.reviews
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

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to  bookings_path
    else
      redirect_to  bookings_path
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, status: :see_other
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total, :status)
  end
end
