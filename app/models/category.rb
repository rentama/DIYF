class Category < ApplicationRecord
  has_many :fermentations
  attr_accessor :fermentation_name
end
