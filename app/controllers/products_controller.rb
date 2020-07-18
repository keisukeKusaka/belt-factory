class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new

    @client = Client.all
    @material = Material.all

    new_id_int = Product.maximum(:number).to_i + 1
    @new_id = "%06d" % new_id_int
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def product_params
    params.require(:product).permit(:number, :length, :width, :client_id, :material_id).merge(user_id: current_user.id)
  end
end
