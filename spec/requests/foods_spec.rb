require 'rails_helper'

RSpec.describe 'Foods Index Page', type: :feature do
  before(:each) do
    @user = User.create(
      id: 3,
      name: 'foga',
      email: 'kat@gmail.com',
      password: 'test123',
      confirmed_at: Time.now
    )

    @foods = [
      Food.create(
        id: 1,
        user_id: @user.id,
        name: 'Rice',
        measurement_unit: 'kg',
        quantity: 3,
        price: 4
      ),
      Food.create(
        id: 2,
        user_id: @user.id,
        name: 'Bread',
        measurement_unit: 'gramms',
        quantity: 4,
        price: 1
      )
    ]
    visit new_user_session_path # Assuming this is your sign-in page
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit foods_path
  end

  describe 'Index page' do
    it 'displays the food names' do
      @foods.each do |food|
        expect(page).to have_content(food.name)
      end
    end

    it 'displays the measurement units' do
      @foods.each do |food|
        expect(page).to have_content(food.measurement_unit)
      end
    end

    it 'displays the prices' do
      @foods.each do |food|
        expect(page).to have_content(food.price)
      end
    end
  end
end
