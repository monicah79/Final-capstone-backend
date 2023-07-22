require 'rails_helper'

RSpec.describe Laptop, type: :model do
  let(:user) { FactoryBot.create(:user) }
  subject { FactoryBot.create(:laptop, user:) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a non-numeric price' do
      subject.price = 'not a number'
      expect(subject).to_not be_valid
    end

    it 'is not valid with a price less than or equal to zero' do
      subject.price = 0
      expect(subject).to_not be_valid
    end

    it 'is not valid with a non-numeric memory' do
      subject.memory = 'not a number'
      expect(subject).to_not be_valid
    end

    it 'is not valid with a memory less than or equal to zero' do
      subject.memory = 0
      expect(subject).to_not be_valid
    end

    it 'is not valid with a non-numeric storage' do
      subject.storage = 'not a number'
      expect(subject).to_not be_valid
    end

    it 'is not valid with a storage less than or equal to zero' do
      subject.storage = 0
      expect(subject).to_not be_valid
    end
  end
end
