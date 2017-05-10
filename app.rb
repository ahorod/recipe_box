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
  @ingredients = Ingredient.all()
  @tags = Tag.all()
  @recipe = Recipe.find(id)
  @my_ingredients = @recipe.ingredients()
  @my_tags = @recipe.tags()

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
