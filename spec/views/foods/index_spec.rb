require 'rails_helper'

RSpec.describe 'foods/index.html.erb', type: :feature do
    before(:each) do
        @user = User.create(
          id: 3,
          name: 'Dj',
          email: 'dj@mail.com',
          password: 'test123',
          confirmed_at: Time.now
        )
    
        @foods = Food.create(
            id: 1,
            user_id: @user.id,
            name: 'Rice',
            measurement_unit: 'kg',
            quantity: 3,
            price: 4
          )
        visit new_user_session_path 
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        visit foods_path
  end

  it 'displays the heading' do
    expect(page).to have_content('Foods page')
  end

  it 'displays "Add Food" button for the current user' do
    expect(page).to have_button('Add Food')
  end

  it 'displays the table with food items' do
    expect(page).to have_selector('table.table-striped')
    expect(page).to have_selector('th', text: 'Food')
    expect(page).to have_selector('th', text: 'Measurement unit')
    expect(page).to have_selector('th', text: 'Unit price')
    expect(page).to have_selector('th', text: 'Actions')
    expect(page).to have_selector('td', text: 'Rice')
    expect(page).to have_selector('td', text: 'kg')
    expect(page).to have_selector('td', text: '4.0')
    expect(page).to have_button('Delete')
  end

  it 'displays "No foods found" message when no foods are present' do
    all('tr').each do |row|
        within(row) do
          click_button('Delete') if has_button?('Delete') # Check if the button is present to avoid errors
        end
      end
      expect(page).to have_content('Food was successfully deleted.')
      page.refresh
      expect(page).to have_content('No foods found')
  end
end
