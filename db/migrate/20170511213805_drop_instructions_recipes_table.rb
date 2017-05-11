class DropInstructionsRecipesTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :ingredients_recipes
  end
end
