class LaptopReservationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_laptop_reservation, only: %i[show]

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: 'Laptop Reservation not found' }, status: :not_found
  end

  def index
    render json: @laptop_reservations
  end

  def show
    render json: @laptop_reservation
  end

  private

  def set_laptop_reservation
    @laptop_reservation = LaptopReservation.find(params[:id])
  end
end
