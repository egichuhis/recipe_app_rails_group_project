require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) do
    User.create(id: 1,
                name: 'John Doe',
                email: 'johndoe@gmail.com',
                password: '123_456',
                confirmed_at: Time.now)
  end
  let(:recipe) do
    Recipe.create(name: 'Apples',
                  preparation_time: '1 hour',
                  cooking_time: '30 minutes',
                  description: 'Lorem ipsum',
                  is_public: false,
                  user_id: user.id)
  end
  it 'Name should not be empty' do
    recipe.name = nil
    expect(recipe).to_not be_valid
  end

  it 'Description should not be empty' do
    recipe.description = nil
    expect(recipe).to_not be_valid
  end

  it 'Cooking time should not be empty' do
    recipe.cooking_time = nil
    expect(recipe).to_not be_valid
  end

  it 'Preperation time should not be empty' do
    recipe.preparation_time = nil
    expect(recipe).to_not be_valid
  end
end
