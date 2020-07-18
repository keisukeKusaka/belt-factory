class ProductionDataController < ApplicationController
  def create
    production_datum = Production_datum.create(production_data_params)
    # redirect_to root_path
  end

  private
  def production_data_params
    params.require(:production_datum).permit(:text, :image).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
