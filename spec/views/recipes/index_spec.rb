# spec/features/recipes_index_spec.rb

require 'rails_helper'

RSpec.feature 'Recipes index page' do
  before(:each) do
    @user = User.create!(id: 2,
                         name: 'becky',
                         email: 'becky@mail.com',
                         password: 'abcxyz123',
                         confirmed_at: Time.now)

    @recipe = Recipe.create(user_id: @user.id,
                            name: 'Kabsah',
                            description: 'The best in the west',
                            cooking_time: 45,
                            preparation_time: 40,
                            is_public: true)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit recipes_path
  end

  scenario 'displays public recipes' do
    expect(page).to have_content('Public Recipes')
    expect(page).to have_content(@recipe.name)
    expect(page).to have_content("By #{@recipe.user.name}")
    expect(page).to have_content("Total food items: #{@recipe.foods.count}")
    expect(page).to have_content("Total price: $#{@recipe.recipes_total_price}")

    if @recipe.user == @user
      expect(page).to have_button('Delete')
    else
      expect(page).not_to have_button('Delete')
    end
  end
end
