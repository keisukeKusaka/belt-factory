class ProductsController < ApplicationController
  before_action :new_action_only_sales, {only: :new}

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

  def search
    @product = Product.find_by(number: params[:number])
    unless @product.blank?
      redirect_to "/products/#{@product.id}"
    end
  end

  def show
    @product = Product.find(params[:id])

    @product_number = @product.number
    @product_campany = @product.client.campany
    @product_material = @product.material.name
    @product_length = @product.length
    @product_width = @product.width
    @product_weight = (@product.length * @product.width * @product.material.basis_weight / 100).round(1)

    @production_datum = @product.production_datum
    @inspection_datum = @product.inspection_datum
    @evaluation_datum = @product.evaluation_datum
  end

  private

  def product_params
    params.require(:product).permit(:number, :length, :width, :client_id, :material_id).merge(user_id: current_user.id)
  end

  def new_action_only_sales
      redirect_to root_path if current_user.department_id != 2
  end
end
