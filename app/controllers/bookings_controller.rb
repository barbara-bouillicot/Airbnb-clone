class BookingsController < ApplicationController
  before_action :set_booking, only:[:show, :destroy]
  before_action :authenticate_user!, only: [:new, :create]


  def index
    @bookings_made = current_user.bookings
    @listings = Listing.where(user: current_user)
    @booking_requests_received = Booking.where(listing: @listings)
  end

  def show
    @booking = Booking.find(params[:id])
    @reviews = @booking.reviews
    @listing = @booking.listing
    @markers = [
    {
      lat: @listing.latitude,
      lng: @listing.longitude,
    }]
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
      render "bookings/_new", status: :unprocessable_entity
      flash[:alert] = "You need to sign in or sign up before continuing."
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
    redirect_to bookings_url, notice: "Booking successfully deleted!"
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total, :status, :number_of_pets)
  end
end
