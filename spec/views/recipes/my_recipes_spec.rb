# spec/features/my_recipes_spec.rb

require 'rails_helper'

RSpec.describe 'My Recipes page', type: :feature do
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

    @recipe2 = Recipe.create(user_id: 3,
                             name: 'Rice',
                             description: 'The best in the west',
                             cooking_time: 45,
                             preparation_time: 20,
                             is_public: true)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit recipes_path
  end

  scenario 'displays user\'s recipes with remove button' do
    visit my_recipes_path

    expect(page).to have_content('My Recipes')
    expect(page).to have_content(@recipe1.name)
    expect(page).to have_content(@recipe1.description)

    within('.row', text: @recipe1.name) do
      expect(page).to have_link('REMOVE', href: recipe_path(@recipe1))
    end
  end
end
