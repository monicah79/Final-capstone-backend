require 'rails_helper'

RSpec.describe 'LaptopReservations', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    # signup user
    post '/signup', params: { user: { name: user.name, email: "bbb@exam.com", password: user.password } }
    puts response.body
    expect(response).to have_http_status(:success)

    # login user
    post '/login', params: { user: { email: "bbb@exam.com", password: user.password } }
    expect(response).to have_http_status(:success)
    @authorization = response.headers['Authorization']
    

  end

  describe "POST #create" do
    context "when a user is authenticated" do
        let(:valid_attributes) do
            {
              laptop_reservation: FactoryBot.attributes_for(:laptop_reservation).merge(
                laptop_id: FactoryBot.create(:laptop).id
              )
            }
        end

      it "creates a new laptop reservation" do
        expect {
            post '/laptop_reservations', params: valid_attributes, headers: { 'Authorization' => @authorization }
        }.to change(LaptopReservation, :count).by(1)
      end

      it "returns a status of :created" do
        post '/laptop_reservations', params: valid_attributes, headers: { 'Authorization' => @authorization }
        expect(response).to have_http_status(:created)
      end

      it "returns the new laptop reservation" do
        post '/laptop_reservations', params: valid_attributes, headers: { 'Authorization' => @authorization }
        expect(response.body).to match(/New York/)
      end
    end

    context "when a user is not authenticated" do
      
    end
  end
end
