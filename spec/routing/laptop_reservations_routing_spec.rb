require 'rails_helper'

RSpec.describe LaptopReservationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/laptop_reservations').to route_to('laptop_reservations#index')
    end

    it 'routes to #show' do
      expect(get: '/laptop_reservations/1').to route_to('laptop_reservations#show', id: '1')
    end
  end
end
