require 'rails_helper'

RSpec.describe 'recipes/shopping_list', type: :view do
  let(:user) do
    User.create!(id: 1,
                 name: 'Edwin',
                 email: 'edwin@mail.com',
                 password: '123456',
                 confirmed_at: Time.now)
  end
  let(:food) do
    Food.create(user_id: user.id,
                name: 'Food1',
                measurement_unit: 'kg',
                price: 9.99,
                quantity: 10)
  end
  let(:food2) do
    Food.create(user_id: user.id,
                name: 'Food2',
                measurement_unit: 'kg',
                price: 9,
                quantity: 1)
  end
  let(:recipe) do
    Recipe.create(user_id: user.id,
                  name: 'Apple',
                  description: 'The best in the west',
                  cooking_time: 45,
                  preparation_time: 40,
                  is_public: true)
  end
  let(:recipe_food) do
    RecipeFood.create(recipe:, food:, quantity: 10)
  end
  let(:recipe_food2) do
    RecipeFood.create(recipe:, food: food2, quantity: 10)
  end
  before do
    assign(:recipe, recipe)
    assign(:recipe_food, recipe_food)
    assign(:recipe_food2, recipe_food2)
    render
  end

  it 'displays the shopping list correctly' do
    expect(rendered).to have_content('Shopping List')
    expect(rendered).to have_content("Amount of food items to buy: #{recipe.recipe_foods.count}")
    expect(rendered).to have_content("Total value of food needed: $#{recipe.recipes_total_price}")

    expect(rendered).to have_content(food.name)
    expect(rendered).to have_content("#{recipe_food.quantity} #{food.measurement_unit}")
    expect(rendered).to have_content("$#{recipe_food.value}")

    expect(rendered).to have_content(food2.name)
    expect(rendered).to have_content("#{recipe_food2.quantity} #{food2.measurement_unit}")
    expect(rendered).to have_content("$#{recipe_food2.value}")
  end
end
