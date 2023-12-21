# spec/features/foods_spec.rb

require 'rails_helper'

RSpec.feature 'Foods', type: :feature do
    before(:each) do
        @user = User.create(
          id: 3,
          name: 'Dj',
          email: 'dj@mail.com',
          password: 'test123',
          confirmed_at: Time.now
        )

    visit new_user_session_path 
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    visit foods_path
    end
  scenario 'user creates a new food' do

    visit new_food_path
    # Fill in the form with valid data
    fill_in 'Name', with: 'New Food'
    select 'Pieces', from: 'Measurement unit'
    fill_in 'Price', with: 2.5
    fill_in 'Quantity', with: 10

    click_button 'Create food'

    expect(page).to have_content('Food was successfully created.')
    expect(page).to have_content('New Food')
    expect(page).to have_content('Pieces')
    expect(page).to have_content('2.5')
  end
end
