class CategoriesController < ApplicationController
  authorize_resource

  def index
    @categories = Category.all.includes(:fermentations)
  end

  def new
    @category = Category.new
  end

  def create
    data = create_params
    category = Category.where(name: data[:name]).first_or_create
    fermentation = category.fermentations.where(name: data[:fermentation_name]).first_or_create
    redirect_to new_category_fermentation_product_url(category, fermentation)
  end

  private
  def create_params
    params.require(:category).permit(:name, :fermentation_name)
  end
end
