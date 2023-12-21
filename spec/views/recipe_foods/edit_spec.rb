RSpec.describe 'recipe_foods/edit.html.erb', type: :view do
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
  let(:recipe) do
    Recipe.create(user_id: user.id,
                  name: 'Apple',
                  description: 'The best in the west',
                  cooking_time: 45,
                  preparation_time: 40,
                  is_public: true)
  end
  # Assuming you have a factory for RecipeFood model
  let(:recipe_food) do
    RecipeFood.create(recipe:, food:, quantity: 10)
  end

  before do
    assign(:recipe, recipe)
    assign(:recipe_food, recipe_food)

    render
  end

  it 'renders the form' do
    expect(rendered).to have_selector("form[action='#{recipe_recipe_food_path(recipe, recipe_food)}'][method='post']") # Assuming the method is post in your case
    expect(rendered).to have_field('recipe_food[food_id]', type: 'select', with: recipe_food.food_id)
    expect(rendered).to have_field('recipe_food[quantity]', type: 'number', with: recipe_food.quantity)
    expect(rendered).to have_button('Modify Ingredient')
  end

  # Add more tests as needed to cover form submission and other scenarios
end
