class InspectionDataController < ApplicationController
  load_and_authorize_resource

  def create
    @inspection_datum = InspectionDatum.create(inspection_datum_params)
    redirect_to "/products/#{params[:product_id]}"
  end

  def update
    @inspection_datum = InspectionDatum.find(params[:id])
    @inspection_datum.update(inspection_datum_params)
    redirect_to product_path(params[:product_id])
  end

  private

  def inspection_datum_params
    params.require(:inspection_datum).permit(:length, :width, :weight, :comment, :image, :created_at).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
