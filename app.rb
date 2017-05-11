require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/tag')
require('./lib/recipe')
require('./lib/ingredient')
require('pry')
require("pg")

get("/") do
  erb(:index)
end

get('/recipes/new') do
  @recipes = Recipe.all()
  erb(:recipes)
end

post('/recipes') do
  name = params.fetch('name')
  rating = params.fetch('rating')
  recipe = Recipe.create({:name => name, :rating => rating})
  @recipes = Recipe.all()
  erb(:recipes)
end

get('/ingredients/new') do
  @ingredients = Ingredient.all()
  erb(:ingredients)
end

post('/ingredients') do
  name = params.fetch('name')
  ingredient = Ingredient.create({:name => name})
  @ingredients = Ingredient.all()
  erb(:ingredients)
end

get('/tags/new') do
  @tags = Tag.all()
  erb(:tags)
end

post('/tags') do
  name = params.fetch('name')
  tag = Tag.create({:name => name})
  @tags = Tag.all()
  erb(:tags)
end

get('/tags/:id') do
  id = params.fetch('id').to_i
  @tag = Tag.find(id)
  erb(:tag)
end
patch('/tag_update/:id') do
  id = params.fetch('id').to_i
  name = params.fetch('name')
  @tag = Tag.find(id)
  @tag.update(:name => name)
  erb(:tag)
end

delete('/tag_delete/:id') do
  id = params.fetch('id').to_i
  @tag = Tag.find(id)
  @tag.delete()
  @tags = Tag.all()
  erb(:tags)
end

get('/recipes/:id') do
  id = params.fetch('id').to_i
  @recipe = Recipe.find(id)
  @ingredients = Ingredient.all()
  @tags = Tag.all()
  @my_ingredients = @recipe.ingredients()
  @my_tags = @recipe.tags()
  erb(:recipe)
end

patch('/add_ingredient/:id') do
  id = params.fetch('id').to_i
  ingredient_ids = params.fetch("ingredient_ids", "")
  tag_ids = params.fetch('tag_ids', "")
  instructions = params.fetch('instructions')

  @ingredients = Ingredient.all()
  @tags = Tag.all()
  @recipe = Recipe.find(id)
  @my_ingredients = @recipe.ingredients()
  @my_tags = @recipe.tags()
  @recipe.update(:instruction => instructions)

  if ingredient_ids != ""
    ingredient_ids.each() do |ingredient_id|
      ingredient = Ingredient.find(ingredient_id)
      @my_ingredients = @recipe.ingredients.push(ingredient)
    end
  end
  if tag_ids != ""
    tag_ids.each() do |tag_id|
      tag = Tag.find(tag_id)
      @my_tags = @recipe.tags.push(tag)
    end
  end
  erb(:recipe)
end
get('/:recipe_id/ingredient/:id') do
  id = params.fetch('id').to_i
  recipe_id = params.fetch('recipe_id').to_i
  @recipe= Recipe.find(recipe_id)
  ingredient = Ingredient.find(id)

  @recipe.ingredients.destroy(ingredient)
  @my_ingredients = @recipe.ingredients()
  @my_tags = @recipe.tags()
  @ingredients = Ingredient.all()
  @tags = Tag.all()
  erb(:recipe)
end
get('/:recipe_id/tag/:id') do
  id = params.fetch('id').to_i
  recipe_id = params.fetch('recipe_id').to_i
  @recipe= Recipe.find(recipe_id)
  tag = Tag.find(id)
  @recipe.tags.destroy(tag)

  @my_ingredients = @recipe.ingredients()
  @my_tags = @recipe.tags()
  @ingredients = Ingredient.all()
  @tags = Tag.all()
  erb(:recipe)
end
delete('/recipe_delete/:id') do
  id = params.fetch('id').to_i
  recipe = Recipe.find(id)
  ingredients = recipe.ingredients()
  tags = recipe.tags()
  recipe.delete()
  recipe.ingredients.destroy(ingredients)
  recipe.tags.destroy(tags)
  @recipes = Recipe.all()
  erb(:recipes)
end

get('/ingredients/:id') do
  @recipes = Recipe.all()
  id = params.fetch('id').to_i
  @ingredient = Ingredient.find(id)
  @ingredient_recipes = @ingredient.recipes()
  erb(:ingredient)
end

patch('/ingredient_update/:id') do
  id = params.fetch("id").to_i
  name = params.fetch("name")
  @ingredient = Ingredient.find(id)
  @ingredient.update(:name => name)
  @ingredient_recipes = @ingredient.recipes()
  erb(:ingredient)
end

delete('/ingredient_delete/:id') do
  id = params.fetch("id").to_i
  ingredient = Ingredient.find(id)
  ingredient.delete()
  @ingredients = Ingredient.all()
  erb(:ingredients)
end
