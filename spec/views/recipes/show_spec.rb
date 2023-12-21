require 'rails_helper'

RSpec.describe 'recipes/show.html.erb', type: :feature do
  before(:each) do
    @user = User.create!(id: 2,
                         name: 'becky',
                         email: 'becky@mail.com',
                         password: 'abcxyz123',
                         confirmed_at: Time.now)
    @food = Food.create(
      id: 1,
      user_id: @user.id,
      name: 'Rice',
      measurement_unit: 'kg',
      quantity: 3,
      price: 4
    )
    @recipe = Recipe.create(user_id: @user.id,
                            name: 'Kabsah',
                            description: 'The best in the west',
                            cooking_time: 45,
                            preparation_time: 40,
                            is_public: true)

    @recipe_food = RecipeFood.create(food: @food, recipe: @recipe, quantity: 1, value: 2)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit recipe_path(@recipe)
  end

  it 'displays recipe details' do
    expect(page).to have_content(@recipe.name)
    expect(page).to have_content("Preparation time: #{@recipe.preparation_time} hours")
    expect(page).to have_content("Cooking time: #{@recipe.cooking_time} hours")
  end

  it 'renders the form for the current user' do
    if @recipe.user == @user
      expect(page).to have_selector("form[action='#{recipe_path(@recipe)}'][method='post']")
    else
      expect(page).not_to have_selector("form[action='#{recipe_path(@recipe)}'][method='post']")
    end
  end

  it 'displays recipe foods in the table' do
    expect(page).to have_content(@recipe_food.food.name)
    expect(page).to have_content(@recipe_food.quantity)
    expect(page).to have_content(@recipe_food.value)
  end
end
