class ListsController < ApplicationController
  def index
    @products = Product.includes(:production_datum, :inspection_datum, :evaluation_datum, :material, :client).order("created_at DESC").page(params[:page]).per(10)
  end
end
