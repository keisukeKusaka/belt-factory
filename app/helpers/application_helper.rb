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

  def create_production_datum
    if @production_datum.present?
      @production_datum_comment = @production_datum.comment
      @production_datum_image = @production_datum.image.url if @production_datum.image.present?
      @production_datum_created_at = @production_datum.created_at.strftime("%Y/%m/%d")
      @production_datum_name = @production_datum.user.name
    end
  end

  def create_inspection_datum
    if @inspection_datum.present?
      @inspection_datum_length = @inspection_datum.length
      @inspection_datum_width = @inspection_datum.width
      @inspection_datum_weight = @inspection_datum.weight
      @inspection_datum_comment = @inspection_datum.comment
      @inspection_datum_image = @inspection_datum.image.url if @inspection_datum.image.present?
      @inspection_datum_created_at = @inspection_datum.created_at.strftime("%Y/%m/%d")
      @inspection_datum_name = @inspection_datum.user.name
    end
  end

  def create_evaluation_datum
    if @evaluation_datum.present?
      @evaluation_datum_comment = @evaluation_datum.comment
      @evaluation_datum_image = @evaluation_datum.image.url if @evaluation_datum.image.present?
      @evaluation_datum_created_at = @evaluation_datum.created_at.strftime("%Y/%m/%d")
      @evaluation_datum_name = @evaluation_datum.user.name
    end
  end

  def weight(product)
    weight = (product.length * product.width * product.material.basis_weight / 100).round(1)
    "#{weight}"
  end
end
