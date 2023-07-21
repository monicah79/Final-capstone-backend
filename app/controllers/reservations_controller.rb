class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    reservations = Reservation.all

    render json: reservations
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
end
