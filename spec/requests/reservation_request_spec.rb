require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
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
        get '/reservations', headers: { 'Authorization' => @authorization }
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

  describe 'GET #show' do
    context 'when a user is authenticated' do
      let(:laptop) { FactoryBot.create(:laptop) }
      let(:reservation_params) do
        {
          reservation: {
            laptop_id: laptop.id,
            quantity: 1,
            city: 'New York'
          }
        }
      end

      it 'returns a status of :ok' do
        post '/reservations', params: reservation_params, headers: { 'Authorization' => @authorization }
        expect(response).to have_http_status(:created)
        reservation_id = JSON.parse(response.body)['reservation']['id']

        get "/reservations/#{reservation_id}", headers: { 'Authorization' => @authorization }
        expect(response).to have_http_status(:ok)
      end

      it 'returns the reservation of the current user' do
        post '/reservations', params: reservation_params, headers: { 'Authorization' => @authorization }
        expect(response).to have_http_status(:created)
        reservation_id = JSON.parse(response.body)['reservation']['id']

        get "/reservations/#{reservation_id}", headers: { 'Authorization' => @authorization }
        expect(response.body).to include('New York')
      end

      it 'returns a status of :not_found if the reservation does not exist' do
        get '/reservations/12345', headers: { 'Authorization' => @authorization }
        expect(response).to have_http_status(:not_found)
      end
    end
  end


  describe 'POST #create' do
    context 'when a user is authenticated' do
      let(:laptop) { FactoryBot.create(:laptop) }
      let(:valid_attributes) do
        {
          reservation: {
            laptop_id: laptop.id,
            quantity: 1,
            city: 'New York'
          }
        }
      end

      it 'creates a new reservation' do
        expect do
          post '/reservations', params: valid_attributes, headers: { 'Authorization' => @authorization }
        end.to change(Reservation, :count).by(1)
      end

      it 'returns a status of :created' do
        post '/reservations', params: valid_attributes, headers: { 'Authorization' => @authorization }
        expect(response).to have_http_status(:created)
      end

      it 'returns the new reservation and its associated laptop reservation' do
        post '/reservations', params: valid_attributes, headers: { 'Authorization' => @authorization }
        expect(response.body).to include('New York')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when a user is authenticated' do
      let(:laptop) { FactoryBot.create(:laptop) }
      let(:reservation) { FactoryBot.create(:reservation, user:) }
      let!(:laptop_reservation) do
        FactoryBot.create(:laptop_reservation, reservation_id: reservation.id, laptop_id: laptop.id, quantity: 1,
                                               city: 'New York')
      end

      it 'returns a status of :not_found if the reservation does not exist' do
        delete '/reservations/12345', headers: { 'Authorization' => @authorization }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Reservation not found.')
      end
    end
  end
end
