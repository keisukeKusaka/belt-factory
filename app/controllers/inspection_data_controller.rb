class InspectionDataController < ApplicationController
  def create
    @inspection_datum_new = InspectionDatum.create(production_data_params)
    redirect_to "/products/#{params[:product_id]}"
  end

  private

  def production_data_params
    params.require(:inspection_datum).permit(:length, :width, :weight, :comment, :image, :created_at).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
