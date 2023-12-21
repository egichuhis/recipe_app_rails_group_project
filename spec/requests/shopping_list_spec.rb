require 'rails_helper'

RSpec.describe 'General shopping list specs', type: :feature do
  before(:each) do
    @user = User.create!(id: 1,
                         name: 'Edwin',
                         email: 'edwin@mail.com',
                         password: '123456',
                         confirmed_at: Time.now)

    @recipe1 = Recipe.create(user_id: @user.id,
                             name: 'Apple',
                             description: 'The best in the west',
                             cooking_time: 45,
                             preparation_time: 40,
                             is_public: true)

    @food = Food.create(user_id: @user.id,
                        name: 'Food',
                        measurement_unit: 'Gram',
                        price: 9.99,
                        quantity: 10)

    RecipeFood.create(food: @food, recipe: @recipe1, quantity: 1)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit general_shopping_list_path
  end

  it 'see the title' do
    expect(page).to have_content('General Shopping List')
  end
  it 'see some page features' do
    expect(page).to have_content('Amount of food items to buy: 0')
    expect(page).to have_content('Total value of food needed: 0')
  end
end
