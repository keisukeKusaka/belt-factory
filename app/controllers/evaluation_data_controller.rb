class EvaluationDataController < ApplicationController
  load_and_authorize_resource

  def create
    @evaluation_datum_new = EvaluationDatum.create(evaluation_datum_params)
    if @evaluation_datum_new.save
      flash[:notice] = "#{@evaluation_datum.product.number} 顧客評価の登録が完了しました。"
      redirect_to product_path(params[:product_id])
    else
      flash[:alert] = "#{@evaluation_datum.product.number} 顧客評価の登録に失敗しました。全ての必須項目を入力してください。"
      redirect_to product_path(params[:product_id])
    end
  end

  def update
    @evaluation_datum = EvaluationDatum.find(params[:id])
    if @evaluation_datum.update(evaluation_datum_params)
      flash[:notice] = "#{@evaluation_datum.product.number} 顧客評価の変更が完了しました。"
      redirect_to product_path(params[:product_id])
    else
      flash[:alert] = "#{@evaluation_datum.product.number} 顧客評価の変更に失敗しました。全ての必須項目を入力してください。"
      redirect_to product_path(params[:product_id])
    end
  end

  private

  def evaluation_datum_params
    params.require(:evaluation_datum).permit(:comment, :created_at, evaluation_images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
