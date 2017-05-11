ENV['RACK_ENV'] = 'test'

require("rspec")
require("pg")
require("sinatra/activerecord")
require("./lib/tag")
require("./lib/recipe")
require("./lib/ingredient")
require("./lib/dish")


RSpec.configure do |config|
  config.after(:each) do
    Recipe.all().each do |recipe|
      recipe.destroy()
    end
    Tag.all().each do |tag|
      tag.destroy()
    end
    Ingredient.all().each do |ingredient|
      ingredient.destroy()
    end
  end
end
