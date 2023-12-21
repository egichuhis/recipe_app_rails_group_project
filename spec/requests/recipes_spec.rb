require 'rails_helper'

RSpec.describe 'Recipe specs', type: :feature do
  before(:each) do
    @user = User.create!(id: 2,
                         name: 'becky',
                         email: 'becky@mail.com',
                         password: 'abcxyz123',
                         confirmed_at: Time.now)

    @recipe1 = Recipe.create(user_id: @user.id,
                             name: 'Kabsah',
                             description: 'The best in the west',
                             cooking_time: 45,
                             preparation_time: 40,
                             is_public: true)

    visit new_user_session_path # Assuming this is your sign-in page
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit recipes_path
  end

  it 'see the title' do
    expect(page).to have_content('Public Recipes')
    expect(page).to have_content('Kabsah')
  end

  it 'see the recipe details' do
    visit recipe_path(@recipe1)
    expect(page).to have_content('Kabsah')
    expect(page).to have_content('The best in the west')
  end

  it 'create new recipe' do
    click_on 'Add Recipe'
    expect(page).to have_content('Add New Recipe')
    expect(page).to have_button('Create Recipe')
  end
end
