class Recipe < ActiveRecord::Base
  has_many :dishes
  has_many :ingredients, through: :dishes
  has_and_belongs_to_many :tags

  validates(:rating, :presence => true)

end
