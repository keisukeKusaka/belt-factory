class ProductsController < ApplicationController
  include ApplicationHelper
  load_and_authorize_resource
  before_action :new_action_only_sales, only: [:new, :edit]
  before_action :get_parameters, only: [:new, :edit]
  before_action :find_product, only: [:show, :edit]

  def index
    @products = Product.includes(:production_datum, :inspection_datum, :evaluation_datum, :material, :client).order("id DESC").page(params[:page]).per(10)
  end

  def new
    @product = Product.new
    @new_number = "%06d" % (Product.maximum(:number).to_i + 1)
  end

  def create
    @product = Product.new(product_params)
    @product.save
    if @product.save
      flash[:notice] = "#{@product.number}の登録が完了しました。"
      redirect_to product_path(@product)
    else
      flash[:alert] = "#{@product.number}の登録に失敗しました。全ての必須項目を入力してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  def search
    @product = Product.find_by(number: params[:number])
    if @product.present?
      redirect_to product_path(@product)
    else
      flash[:alert] = "検索に失敗しました。登録済みの製品番号を入力してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @production_datum_new = ProductionDatum.new
    @inspection_datum_new = InspectionDatum.new
    @evaluation_datum_new = EvaluationDatum.new

    @production_datum_new.production_images.new
    @inspection_datum_new.inspection_images.new
    @evaluation_datum_new.evaluation_images.new
  end

  def edit
    if @product.production_datum.present?
      flash[:alert] = "#{@product.number}は製作工程が完了しているため設計を変更できません。"
      redirect_to product_path(@product)
    end
  end

  def update
    product = Product.find(params[:id])
    if product.production_datum.present?
      flash[:alert] = "#{product.number}は製作工程が完了しているため設計を変更できません。"
      redirect_to product_path(product)
    else
      product.update(product_params)
      if product.update(product_params)
        flash[:notice] = "#{product.number}の設計変更が完了しました。"
        redirect_to product_path(product)
      else
        flash[:alert] = "#{@product.number}の設計変更に失敗しました。全ての必須項目を入力してください。"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def destroy
    product = Product.find(params[:id])
    if product.production_datum.present?
      flash[:alert] = "#{product.number}は製作工程が完了しているため削除できません。"
      redirect_to product_path(product)
    else
      if product.destroy
        flash[:delete] = "#{product.number}を削除しました。"
        redirect_to root_path
      else
        flash[:alert] = "#{@product.number}の削除に失敗しました。"
        redirect_back(fallback_location: root_path)
      end

    end
  end

  private

  def product_params
    params.require(:product).permit(:number, :length, :width, :comment,:client_id, :material_id).merge(user_id: current_user.id)
  end

  def new_action_only_sales
      redirect_to root_path if current_user.department_id != 2
  end

  def get_parameters
    @client = Client.all
    @material = Material.all
  end

  def find_product
    @product = Product.find(params[:id])
    product_datum(@product)
    @products = Product.where(client_id: @product.client_id).order("created_at DESC").page(params[:page]).per(5)
  end
end
