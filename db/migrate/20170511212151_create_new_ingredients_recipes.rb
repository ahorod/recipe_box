class CreateNewIngredientsRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table(:dishes) do |t|
      t.column(:ingredient_id, :integer)
      t.column(:recipe_id, :integer)
      t.column(:quantity, :integer)
      t.column(:measurement, :string)

      t.timestamps()
    end
  end
end
