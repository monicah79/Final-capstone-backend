require 'rails_helper'

RSpec.describe LaptopReservationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/laptop_reservations').to route_to('laptop_reservations#index')
    end

    it 'routes to #show' do
      expect(get: '/laptop_reservations/1').to route_to('laptop_reservations#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/laptop_reservations').to route_to('laptop_reservations#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/laptop_reservations/1').to route_to('laptop_reservations#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/laptop_reservations/1').to route_to('laptop_reservations#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/laptop_reservations/1').to route_to('laptop_reservations#destroy', id: '1')
    end
  end
end
