class CreateRecipesFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_foods do |t|
      t.integer :quantity
      t.integer :value
      t.references :food, null:false, foreign_key: {to_table: :foods}
      t.references :recipe, null:false, foreign_key: {to_table: :recipes}

      t.timestamps
    end
  end
end
