class Ingredient < ActiveRecord::Base
  has_many :dishes
  has_many :recipes, through: :dishes

end
