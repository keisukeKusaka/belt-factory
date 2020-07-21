class EvaluationDataController < ApplicationController
  def create
    @production_datum_new = EvaluationDatum.create(evaluation_data_params)
    redirect_to "/products/#{params[:product_id]}"
  end

  private

  def evaluation_data_params
    params.require(:evaluation_datum).permit(:comment, :image, :created_at).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
