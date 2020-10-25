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
end
