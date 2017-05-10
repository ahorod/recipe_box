require("spec_helper")


describe(Recipe) do
  describe('#ingredients') do
    it('each recipe has many ingredients') do
      recipe = Recipe.create({:name => "annas breakfast"})
      ingredient1 = recipe.ingredients.create({:name => 'cheerios'})
      ingredient2 = recipe.ingredients.create({:name => 'yogurt'})

      expect(recipe.ingredients()).to(eq([ingredient1, ingredient2]))
    end
  end

  describe('#tags') do
    it('each recipe has many tags') do
      recipe = Recipe.create({:name => "annas breakfast"})
      tag1 = recipe.tags.create({:name => 'delicious'})
      tag2 = recipe.tags.create({:name => 'healthy'})

      expect(recipe.tags()).to(eq([tag1, tag2]))
    end
  end
end
