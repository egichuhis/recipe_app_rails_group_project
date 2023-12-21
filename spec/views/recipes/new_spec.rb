# spec/features/new_recipe_spec.rb

require 'rails_helper'

RSpec.describe 'New Recipe page', type: :feature do
  before(:each) do
    @user = User.create!(id: 2,
                         name: 'becky',
                         email: 'becky@mail.com',
                         password: 'abcxyz123',
                         confirmed_at: Time.now)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit recipes_path
  end

  scenario 'displays the new recipe form' do
    visit new_recipe_path
    expect(page).to have_content('Add New Recipe')

    expect(page).to have_field('Name', type: 'text')
    expect(page).to have_button('Create Recipe')
  end

  scenario 'displays error messages for invalid inputs' do
    visit new_recipe_path

    fill_in 'Name', with: ''
    click_button 'Create Recipe'

    expect(page).to have_content('Recipe cannot be saved:')
  end

  scenario 'creates a new recipe with valid inputs' do
    visit new_recipe_path

    fill_in 'Name', with: 'New Recipe'
    fill_in 'recipe[preparation_time]', with: '30'
    fill_in 'recipe[cooking_time]', with: '45'
    fill_in 'recipe[description]', with: 'A delicious recipe'
    check 'recipe[is_public]'
    click_button 'Create Recipe'

    expect(page).to have_content('Recipe was successfully created.')
  end
end
