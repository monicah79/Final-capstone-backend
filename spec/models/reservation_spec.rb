require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:user) { FactoryBot.create(:user) }
  subject { FactoryBot.create(:reservation, user:) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end
  end
end
