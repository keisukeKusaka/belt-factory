module ApplicationHelper
  def user_department_and_datum?(num, datum)
    current_user.department_id == num && datum.blank?
  end
end
