module ApplicationHelper
  def user_department_and_datum?(num, datum)
    current_user.department_id == num && datum.blank? && @product.present?
  end

  def product_datum(product)
    @production_datum = product.production_datum
    @inspection_datum = product.inspection_datum
    @evaluation_datum = product.evaluation_datum
  end

  def weight(product)
    if product.present?
      weight = (product.length * product.width * product.material.basis_weight / 100).round(1)
      "#{weight}"
    end
  end
end
