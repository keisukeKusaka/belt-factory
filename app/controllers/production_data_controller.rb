class ProductionDataController < ApplicationController
  load_and_authorize_resource

  def create
    @production_datum_new = ProductionDatum.create(production_datum_params)
    redirect_to "/products/#{params[:product_id]}"
  end

  def update
    production_datum = ProductionDatum.find(params[:id])
    production_datum.update(production_datum_params)
    redirect_to product_path(params[:product_id])
  end

  private

  def production_datum_params
    params.require(:production_datum).permit(:comment, :image, :created_at).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
