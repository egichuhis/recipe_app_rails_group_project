require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'aisha', email: 'aisha@mail.com', password: '111111') }

  before do
    @food = Food.new(name: 'Apple', quantity: 2, measurement_unit: 'piece', price: 1.99)
  end

  describe 'validations' do
    it 'Is valid with valid attributes' do
      expect(@food).to be_valid
    end

    it 'Is not valid without a name' do
      @food.name = nil
      expect(@food).to_not be_valid
    end

    it 'Is not valid without a measurement unit' do
      @food.measurement_unit = nil
      expect(@food).to_not be_valid
    end
  end
end
