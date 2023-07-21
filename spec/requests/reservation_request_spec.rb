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

  describe 'GET /reservations' do
    it 'returns a list of reservations' do
      # create 10 reservations
      FactoryBot.create_list(:reservation, 10)

      get '/reservations', headers: { Authorization: Authorization }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(10)
    end
  end

  describe 'POST /reservations' do
    it 'creates a reservation' do
      post '/reservations', headers: { Authorization: Authorization }
      expect(response).to have_http_status(:success)
    end
  end
end
