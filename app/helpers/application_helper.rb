module ApplicationHelper
  def user_department_and_datum?(num, datum)
    current_user.department_id == num && datum.blank? && @product.present?
  end

  def create_product_design(product)
    @product_number = product.number
    @product_campany = product.client.campany
    @product_material = product.material.name
    @product_length = product.length
    @product_width = product.width
    @product_weight = (product.length * product.width * product.material.basis_weight / 100).round(1)

    @production_datum = product.production_datum
    @inspection_datum = product.inspection_datum
    @evaluation_datum = product.evaluation_datum
  end

  def create_product_datum(datum)
    unless datum.blank?
      @datum_comment = datum.comment
      @datum_image = datum.image.url if datum.image.present?
      @datum_created_at = datum.created_at.strftime("%Y/%m/%d")
      @datum_name = datum.user.name
      if datum.has_attribute?(:length)
        @datum_length = datum.length
        @datum_width = datum.width
        @datum_weight = datum.weight
      end
    end
  end
end
