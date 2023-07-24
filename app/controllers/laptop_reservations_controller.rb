class LaptopReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_laptop_reservation, only: %i[show update destroy]

  def index
    @laptop_reservations = LaptopReservation.all

    render json: @laptop_reservations
  end

  def show
    render json: @laptop_reservation
  end

  def create
    @laptop_reservation = LaptopReservation.new(laptop_reservation_params)

    if @laptop_reservation.save
      render json: @laptop_reservation, status: :created, location: @laptop_reservation
    else
      render json: @laptop_reservation.errors, status: :unprocessable_entity
    end
  end

  def update
    if @laptop_reservation.update(laptop_reservation_params)
      render json: @laptop_reservation
    else
      render json: @laptop_reservation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @laptop_reservation.destroy
  end

  private

  def set_laptop_reservation
    @laptop_reservation = LaptopReservation.find(params[:id])
  end

  def laptop_reservation_params
    params.require(:laptop_reservation).permit(:name, :quantity, :city)
  end
end
