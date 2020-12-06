class ProductionDataController < ApplicationController
  load_and_authorize_resource

  def create
    @production_datum_new = ProductionDatum.create(production_datum_params)
    if @production_datum_new.save
      flash[:notice] = "#{@production_datum.product.number} 製作工程の登録が完了しました。"
      redirect_to product_path(params[:product_id])
    else
      flash[:alert] = "#{@production_datum.product.number} 製作工程の登録に失敗しました。全ての必須項目を入力してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @production_datum = ProductionDatum.find(params[:id])
    if @production_datum.update(production_datum_params)
      flash[:notice] = "#{@production_datum.product.number} 製作工程の変更が完了しました。"
      redirect_to product_path(params[:product_id])
    else
      flash[:alert] = "#{@production_datum.product.number} 製作工程の変更に失敗しました。全ての必須項目を入力してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def production_datum_params
    params.require(:production_datum).permit(:comment, :created_at, production_images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
