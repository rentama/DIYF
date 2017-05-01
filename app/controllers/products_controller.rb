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
    @product = Product.find(params[:id])
    @user = User.find(@product.user_id)
  end

  def edit
    @category = Category.find(params[:category_id])
    @fermentation = Fermentation.find(params[:fermentation_id])
    @product = Product.find(params[:id])
    @product.category_name = @category.name
    @product.fermentation_name = @fermentation.name
    ingredients = @product.ingredients
    if ingredients[0]
      @product.ingredient1 = ingredients[0].name
      @product.ingredient1_quantity = ingredients[0].quantity
    end
    if ingredients[1]
      @product.ingredient2 = ingredients[1].name
      @product.ingredient2_quantity = ingredients[1].quantity
    end
    if ingredients[2]
      @product.ingredient3 = ingredients[2].name
      @product.ingredient3_quantity = ingredients[2].quantity
    end
    if ingredients[3]
      @product.ingredient4 = ingredients[3].name
      @product.ingredient4_quantity = ingredients[3].quantity
    end
    if ingredients[4]
      @product.ingredient5 = ingredients[4].name
      @product.ingredient5_quantity = ingredients[4].quantity
    end
  end

  def update
    product = Product.find(params[:id])
    product.update(update_params[:product])
    redirect_to category_fermentation_product_path(product.fermentation.category, product.fermentation, product)
  end

  def destroy
    Product.find(params[:id]).delete
    redirect_to root_path
  end

  private
  def create_params
    permitted_params = params.require(:product).permit(:name, :quantity, :place, :process, :detail, :ingredient1, :ingredient1_quantity, :ingredient2, :ingredient2_quantity, :ingredient3, :ingredient3_quantity, :ingredient4, :ingredient4_quantity, :ingredient5, :ingredient5_quantity, "produced_at(1i)", "produced_at(2i)", "produced_at(3i)")
    product_params = {name: permitted_params[:name], quantity: permitted_params[:quantity], place: permitted_params[:place], process: permitted_params[:process], detail: permitted_params[:detail]}
    ingredient_params = {ingredient1: permitted_params[:ingredient1], ingredient1_quantity: permitted_params[:ingredient1_quantity], ingredient2: permitted_params[:ingredient2], ingredient2_quantity: permitted_params[:ingredient2_quantity], ingredient3: permitted_params[:ingredient3], ingredient3_quantity: permitted_params[:ingredient3_quantity], ingredient4: permitted_params[:ingredient4], ingredient4_quantity: permitted_params[:ingredient4_quantity], ingredient5: permitted_params[:ingredient5], ingredient5_quantity: permitted_params[:ingredient5_quantity]}
    date_params = Time.zone.local(permitted_params["produced_at(1i)"].to_i, permitted_params["produced_at(2i)"].to_i, permitted_params["produced_at(3i)"].to_i)
    { product: product_params.merge(produced_at: date_params, user_id: current_user.id, fermentation_id: params[:fermentation_id]) }.merge(ingredients: ingredient_params)
  end

  def update_params
    permitted_params = params.require(:product).permit(:name, :quantity, :place, :process, :detail, :ingredient1, :ingredient1_quantity, :ingredient2, :ingredient2_quantity, :ingredient3, :ingredient3_quantity, :ingredient4, :ingredient4_quantity, :ingredient5, :ingredient5_quantity, "produced_at(1i)", "produced_at(2i)", "produced_at(3i)")
    product_params = {name: permitted_params[:name], quantity: permitted_params[:quantity], place: permitted_params[:place], process: permitted_params[:process], detail: permitted_params[:detail]}
    date_params = Time.zone.local(permitted_params["produced_at(1i)"].to_i, permitted_params["produced_at(2i)"].to_i, permitted_params["produced_at(3i)"].to_i)
    { product: product_params.merge(produced_at: date_params, user_id: current_user.id, fermentation_id: params[:fermentation_id]) }
  end
end
