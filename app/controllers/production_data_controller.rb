class ProductionDataController < ApplicationController
  def create
    @production_datum_new = ProductionDatum.create(production_data_params)
    redirect_to "/products/#{params[:product_id]}"
  end

  private

  def production_data_params
    params.require(:production_datum).permit(:comment, :image, :created_at).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
