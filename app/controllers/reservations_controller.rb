class ReservationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: :create

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: exception.message }, status: :forbidden
  end

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: 'Reservation not found.' }, status: :not_found
  end

  def index
    reservations = @reservations
    reservations_data = reservations.map do |reservation|
      user = reservation.user
      laptop = reservation.laptop
      laptop_reservation = reservation.laptop_reservation
      { reservation:, user:, laptop:, laptop_reservation: }
    end

    render json: reservations_data
  end

  def create
    reservation = Reservation.new
    reservation.user = current_user

    if reservation.save
      laptop_reservation = LaptopReservation.create(
        reservation_id: reservation.id,
        laptop_id: params[:reservation][:laptop_id],
        quantity: params[:reservation][:quantity],
        city: params[:reservation][:city]
      )
      render json: { reservation:, laptop_reservation: }, status: :created
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
