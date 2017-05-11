require('spec_helper')

describe(Ingredient) do
  describe("#recipes") do
    it('has many recipes for an ingredient') do
      ingredient = Ingredient.create({:name => "egg"})

      recipe1 = ingredient.recipes.create({:name => "omlette"})
      recipe2 = ingredient.recipes.create({:name => "cake"})
      # dish1 = Dish.create({:ingredient_id => ingredient.id(), :recipe_id => recipe1.id(), :quantity => "20", :measurement => "gr"})
      # dish2 = Dish.create({:ingredient_id => ingredient.id(), :recipe_id => recipe2.id(), :quantity => "20", :measurement => "gr"})
      expect(ingredient.recipes()).to(eq([recipe1, recipe2]))
    end
  end
end
