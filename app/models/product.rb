class Product < ApplicationRecord
  has_many :ingredients
  has_many :reviews
  has_many :users, through: :eating_or_drinkings
  belongs_to :fermentation

  attr_accessor :ingredient1, :ingredient2, :ingredient3, :ingredient4, :ingredient5, :ingredient1_quantity, :ingredient2_quantity, :ingredient3_quantity, :ingredient4_quantity, :ingredient5_quantity, :category_name, :fermentation_name
end
