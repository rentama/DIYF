class ProductsController < ApplicationController
  authorize_resource

  def new
    @category = Category.find(params[:category_id])
    @fermentation = Fermentation.find(params[:fermentation_id])
    @product = Product.new
  end

  def create
    product = Product.create(create_params[:product])
    ingredients = [[:ingredient1, :ingredient1_quantity], [:ingredient2, :ingredient2_quantity], [:ingredient3, :ingredient3_quantity], [:ingredient4, :ingredient4_quantity], [:ingredient5, :ingredient5_quantity]]
    ingredients.each do |ingredient|
      if create_params[:ingredients][ingredient[0]] != ""
        product.ingredients.create(name: create_params[:ingredients][ingredient[0]], quantity: create_params[:ingredients][ingredient[1]])
      end
    end
    redirect_to root_path
  end

  def show
  end

  private
  def create_params
    permitted_params = params.require(:product).permit(:name, :quantity, :place, :process, :detail, :ingredient1, :ingredient1_quantity, :ingredient2, :ingredient2_quantity, :ingredient3, :ingredient3_quantity, :ingredient4, :ingredient4_quantity, :ingredient5, :ingredient5_quantity, "produced_at(1i)", "produced_at(2i)", "produced_at(3i)")
    product_params = {name: permitted_params[:name], quantity: permitted_params[:quantity], place: permitted_params[:place], process: permitted_params[:process], detail: permitted_params[:detail]}
    ingredient_params = {ingredient1: permitted_params[:ingredient1], ingredient1_quantity: permitted_params[:ingredient1_quantity], ingredient2: permitted_params[:ingredient2], ingredient2_quantity: permitted_params[:ingredient2_quantity], ingredient3: permitted_params[:ingredient3], ingredient3_quantity: permitted_params[:ingredient3_quantity], ingredient4: permitted_params[:ingredient4], ingredient4_quantity: permitted_params[:ingredient4_quantity], ingredient5: permitted_params[:ingredient5], ingredient5_quantity: permitted_params[:ingredient5_quantity]}
    date_params = Time.zone.local(permitted_params["produced_at(1i)"].to_i, permitted_params["produced_at(2i)"].to_i, permitted_params["produced_at(3i)"].to_i)
    { product: product_params.merge(produced_at: date_params, user_id: current_user.id, fermentation_id: params[:fermentation_id]) }.merge(ingredients: ingredient_params)
  end
end
