# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def new_production_guest
    user = User.production_guest
    sign_in user
    redirect_to root_path
  end

  def new_sales_guest
    user = User.sales_guest
    sign_in user
    redirect_to root_path
  end

  def change_to_production_guest
    sign_out current_user
    new_production_guest
  end

  def change_to_sales_guest
    sign_out current_user
    new_sales_guest
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
