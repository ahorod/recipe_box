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
  @my_ingredients = []
  erb(:recipe)
end

patch('/add_ingredient/:id') do
  id = params.fetch('id').to_i
  @recipe = Recipe.find(id)
  ingredient_ids = params.fetch("ingredient_ids")

  # if ingredient_ids != nil
    ingredient_ids.each() do |ingredient_id|
      ingredient = Ingredient.find(ingredient_id)
      @my_ingredients = @recipe.ingredients.push(ingredient)
    end

  @ingredients = Ingredient.all()
  @tags = Tag.all()
  erb(:recipe)
  # end
end
