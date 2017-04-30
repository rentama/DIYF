class CategoriesController < ApplicationController
  authorize_resource

  def index
  end

  def new
    @category = Category.new
  end

  def create
    data = create_params
    category = Category.create(name: data[:name])
    fermentation = category.fermentations.create(name: data[:fermentation_name])
    redirect_to new_category_fermentation_product_url(category, fermentation)
  end

  private
  def create_params
    params.require(:category).permit(:name, :fermentation_name)
  end
end
