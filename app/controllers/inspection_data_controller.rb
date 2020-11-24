class InspectionDataController < ApplicationController
  load_and_authorize_resource

  def create
    @inspection_datum_new = InspectionDatum.create(inspection_datum_params)
    if @inspection_datum_new.save
      redirect_to product_path(params[:product_id])
    else
      #失敗時にエラーメッセージを表示するよう設定する事
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @inspection_datum = InspectionDatum.find(params[:id])
    @inspection_datum.update(inspection_datum_params)
    if @inspection_datum.update(inspection_datum_params)
      redirect_to product_path(params[:product_id])
    else
      #失敗時にエラーメッセージを表示するよう設定する事
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def inspection_datum_params
    params.require(:inspection_datum).permit(:length, :width, :weight, :comment, :created_at, inspection_images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
