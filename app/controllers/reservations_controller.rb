class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    reservations = Reservation.all
    render json: reservations, include: %i[user laptop laptop_reservation]
  end

  def create
    reservation = Reservation.new
    reservation.user = current_user

    if reservation.save
      render json: reservation, status: :created
    else
      render json: reservation.errors, status: :unprocessable_entity
    end
  end

  def show
    reservation = Reservation.find(params[:id])
    user = reservation.user
    laptop = reservation.laptop
    laptop_reservation = reservation.laptop_reservation
    render json: { reservation:, user:, laptop:, laptop_reservation: }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reservation not found. id might be incorrect or the Reservation might have been deleted' },
           status: :not_found
  end

  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reservation not found. id might be incorrect or the Reservation might have been deleted' },
           status: :not_found
  end
end
