class ProductionDataController < ApplicationController
  load_and_authorize_resource

  def create
    @production_datum_new = ProductionDatum.create(production_datum_params)
    if @production_datum_new.save
      redirect_to product_path(params[:product_id])
    else
      #失敗時にエラーメッセージを表示するよう設定する事
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @production_datum = ProductionDatum.find(params[:id])
    @production_datum.update(production_datum_params)
    if @production_datum.update(production_datum_params)
      redirect_to product_path(params[:product_id])
    else
      #失敗時にエラーメッセージを表示するよう設定する事
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def production_datum_params
    params.require(:production_datum).permit(:comment, :created_at, production_images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
