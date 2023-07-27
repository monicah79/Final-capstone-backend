class LaptopReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_laptop_reservation, only: %i[show destroy]

  def index
    @laptop_reservations = LaptopReservation.all

    render json: @laptop_reservations
  end

  def show
    render json: @laptop_reservation
  end

  # def create
  #   @reservation = Reservation.create(user: current_user)
  #   @laptop_id = params[:laptop_reservation][:laptop_id]
  #
  #   @laptop_reservation = LaptopReservation.new(laptop_reservation_params)
  #   @laptop_reservation.reservation = @reservation
  #   @laptop_reservation.laptop = Laptop.find(@laptop_id)
  #
  #   if @laptop_reservation.save
  #     render json: @laptop_reservation, status: :created
  #   else
  #     render json: @laptop_reservation.errors, status: :unprocessable_entity
  #   end
  # end

  def destroy
    @laptop_reservation.destroy
  end

  private

  def set_laptop_reservation
    @laptop_reservation = LaptopReservation.find(params[:id])
  end

  def laptop_reservation_params
    params.require(:laptop_reservation).permit(:quantity, :city)
  end
end
