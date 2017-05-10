require('spec_helper')

describe(Tag) do
  describe("#recipes") do
    it('has many recipes for a tag') do
      tag = Tag.create({:name => "delicious"})

      recipe = tag.recipes.create({:name => "omlette"})
      recipe2 = tag.recipes.create({:name => "hotdog"})

      expect(tag.recipes()).to(eq([recipe, recipe2]))
    end
  end
end
