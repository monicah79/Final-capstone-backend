class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    reservations = Reservation.all
    reservations_data = reservations.map do |reservation|
      user = reservation.user
      laptop = reservation.laptop
      laptop_reservation = reservation.laptop_reservation
      { reservation: reservation, user: user, laptop: laptop, laptop_reservation: laptop_reservation }
    end
  
    render json: reservations_data
  end

  def create
    reservation = Reservation.new
    laptop_reservation = LaptopReservation.create(reservation_id: reservation.id, laptop_id: params[:reservation][:laptop_id],
                                                  quantity: params[:reservation][:quantity], city: params[:reservation][:city])
    reservation.user = current_user
    # reservation.laptop_reservation = laptop_reservation

    if reservation.save
      render json: {reservation:, laptop_reservation: }, status: :created
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

  private

  def reservation_params
    params.require(:reservation).permit(:laptop_id, :quantity, :city)
  end
end
