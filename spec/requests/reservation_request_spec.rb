require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  # remember to use FactoryBot.build(:user) instead of FactoryBot.create(:user)
  # because FactoryBot.create(:user) will create a user in the database
  # but FactoryBot.build(:user) will only build attributes for a user
  let(:user) { FactoryBot.build(:user) }

  before do
    # signup user
    post '/signup', params: { user: { name: user.name, email: user.email, password: user.password } }
    expect(response).to have_http_status(:success)

    # login user
    post '/login', params: { user: { email: user.email, password: user.password } }
    expect(response).to have_http_status(:success)
    Authorization = response.headers['Authorization'] # rubocop:disable Lint/ConstantDefinitionInBlock
  end

  describe 'GET /reservations/:id' do
    it 'returns a reservation' do
      reservation = FactoryBot.create(:reservation)

      get "/reservations/#{reservation.id}", headers: { Authorization: Authorization }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['id']).to eq(reservation.id)
    end

    it 'returns an error if reservation is not found' do
      get '/reservations/999', headers: { Authorization: Authorization }
      expect(response).to have_http_status(:not_found)
    end
  end
end
