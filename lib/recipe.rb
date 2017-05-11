class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :tags


  # scope :highest_rating, lambda {|rating| where("rating > ?",rating).order("rating ASC") }


end
