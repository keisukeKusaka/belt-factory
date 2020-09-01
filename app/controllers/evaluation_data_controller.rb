class EvaluationDataController < ApplicationController
  load_and_authorize_resource

  def create
    @production_datum_new = EvaluationDatum.create(evaluation_datum_params)
    redirect_to "/products/#{params[:product_id]}"
  end

  private

  def evaluation_datum_params
    params.require(:evaluation_datum).permit(:comment, :image, :created_at).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
