class EvaluationDataController < ApplicationController
  load_and_authorize_resource

  def create
    @evaluation_datum_new = EvaluationDatum.create(evaluation_datum_params)
    if @evaluation_datum_new.save
      redirect_to product_path(params[:product_id])
    else
      #失敗時にエラーメッセージを表示するよう設定する事
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @evaluation_datum = EvaluationDatum.find(params[:id])
    @evaluation_datum.update(evaluation_datum_params)
    if @evaluation_datum.update(evaluation_datum_params)
      redirect_to product_path(params[:product_id])
    else
      #失敗時にエラーメッセージを表示するよう設定する事
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def evaluation_datum_params
    params.require(:evaluation_datum).permit(:comment, :created_at, evaluation_images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
