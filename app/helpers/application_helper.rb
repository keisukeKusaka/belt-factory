module ApplicationHelper
  def append_datum_form?(num, datum_id)
    current_user.department_id == num && datum_id.blank?
  end

  def product_datum(product)
    @production_datum = product&.production_datum
    @production_datum = ProductionDatum.new if @production_datum.blank?

    @inspection_datum = product&.inspection_datum
    @inspection_datum = InspectionDatum.new if @inspection_datum.blank?

    @evaluation_datum = product&.evaluation_datum
    @evaluation_datum = EvaluationDatum.new if @evaluation_datum.blank?
  end

  def append_edit_button?(num, datum_id)
    current_user.department_id == num && datum_id.present?
  end

  def weight(product)
    if product.present?
      weight = (product.length * product.width * product.material.basis_weight / 100).round(1)
      "#{weight}"
    end
  end

  def material_client_present?(params)
    if params[:client_id].present?
      @client_name = Client.find(params[:client_id])[:campany]
    else
      @client_name = "指定なし"
    end

    if params[:material_id].present?
      @material_name = Material.find(params[:material_id])[:name]
    else
      @material_name = "指定なし"
    end

    if params[:material_id].present? && params[:client_id].present?
      @products = Product.where(material_id: params[:material_id]).where(client_id: params[:client_id]).order("id DESC").page(params[:page]).per(10)
    elsif params[:material_id].blank? && params[:client_id].present?
      @products = Product.where(client_id: params[:client_id]).order("id DESC").page(params[:page]).per(10)
    elsif  params[:material_id].present? && params[:client_id].blank?
      @products = Product.where(material_id: params[:material_id]).order("id DESC").page(params[:page]).per(10)
    else
      redirect_to root_path
    end
  end

end
