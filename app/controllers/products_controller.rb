class ProductsController < ApplicationController
  include ApplicationHelper
  load_and_authorize_resource
  before_action :new_action_only_sales, {only: :new}

  def index
    @products = Product.includes(:production_datum, :inspection_datum, :evaluation_datum, :material, :client).order("created_at DESC").page(params[:page]).per(10)
  end

  def new
    @product = Product.new

    @client = Client.all
    @material = Material.all

    @new_number = "%06d" % (Product.maximum(:number).to_i + 1)
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to new_product_path
      #失敗時にエラーメッセージを表示するよう設定する事
  end

  def search
    @product = Product.find_by(number: params[:number])
    unless @product.blank?
      redirect_to product_path(@product)
    end
  end

  def show
    @product = Product.find(params[:id])
    product_datum(@product)
    @production_datum_new = ProductionDatum.new
    @inspection_datum_new = InspectionDatum.new
    @evaluation_datum_new = EvaluationDatum.new
    @products = Product.where(client_id: @product.client_id).order("created_at DESC").page(params[:page]).per(5)
  end

  private

  def product_params
    params.require(:product).permit(:number, :length, :width, :comment,:client_id, :material_id).merge(user_id: current_user.id)
  end

  def new_action_only_sales
      redirect_to root_path if current_user.department_id != 2
  end
end
