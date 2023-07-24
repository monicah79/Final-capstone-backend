require 'rails_helper'

RSpec.describe 'Laptops', type: :request do
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
    @authorization = response.headers['Authorization']
  end

  describe 'GET /laptops' do
    it 'returns a list of laptops' do
      # create 10 laptops
      FactoryBot.create_list(:laptop, 10)

      get '/laptops', headers: { Authorization: @authorization }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(10)
    end
  end

  describe 'POST /laptops' do
    it 'creates a laptop' do
      laptop_params = {
        laptop: {
          name: 'MacBook Pro',
          price: 1299.99,
          cpu: 'Intel Core i7',
          memory: 16,
          storage: 512
        }
      }
      post '/laptops', params: laptop_params, headers: { Authorization: @authorization }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /laptops/:id' do
    it 'returns a laptop' do
      laptop = FactoryBot.create(:laptop)

      get "/laptops/#{laptop.id}", headers: { Authorization: @authorization }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['id']).to eq(laptop.id)
    end

    it 'returns an error if laptop is not found' do
      get '/laptops/999', headers: { Authorization: @authorization }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE /laptops/:id' do
    it 'deletes a laptop' do
      laptop = FactoryBot.create(:laptop)

      delete "/laptops/#{laptop.id}", headers: { Authorization: @authorization }
      expect(response).to have_http_status(:success)
    end

    it 'returns an error if laptop is not found' do
      delete '/laptops/999', headers: { Authorization: @authorization }
      expect(response).to have_http_status(:not_found)
    end
  end
end
