require 'rails_helper'
RSpec.describe LaptopReservation, type: :model do
  let(:valid_attributes) do
    {
      laptop: Laptop.create(name: 'Laptop 1', price: 100),
      reservation: Reservation.create(user_id: 1),
      city: 'New York',
      quantity: 1,
      start_date: Date.today,
      end_date: Date.tomorrow
    }
  end

  it 'is valid with valid attributes' do
    laptop_reservation = LaptopReservation.new(valid_attributes)
    expect(laptop_reservation).to be_valid
  end
end
