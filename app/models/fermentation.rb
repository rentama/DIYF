class Fermentation < ApplicationRecord
  belongs_to :category
  has_many :products
end
