require 'rails_helper'

RSpec.describe 'LaptopReservations', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    # signup user
    post '/signup', params: { user: { name: user.name, email: 'bbb@exam.com', password: user.password } }
    expect(response).to have_http_status(:success)

    # login user
    post '/login', params: { user: { email: 'bbb@exam.com', password: user.password } }
    expect(response).to have_http_status(:success)
    @authorization = response.headers['Authorization']
  end

  describe 'GET #index' do
    context 'when a user is authenticated' do
      it 'returns a status of :ok' do
        get '/laptop_reservations', headers: { 'Authorization' => @authorization }
        expect(response).to have_http_status(:ok)
      end

      it 'returns the laptop reservations of the current user' do
        laptop = FactoryBot.create(:laptop)
        reservation_params = {
          reservation: {
            laptop_id: laptop.id,
            quantity: 1,
            city: 'New York'
          }
        }
        post '/reservations', params: reservation_params, headers: { 'Authorization' => @authorization }
        expect(response).to have_http_status(:created)

        get '/laptop_reservations', headers: { 'Authorization' => @authorization }
        expect(response.body).to include('New York')
      end
    end
  end
end
