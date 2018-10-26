class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: :record_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    redirect_to root_path, alert: "Record does not exist!"
  end

  def authenticate_active_admin_user!
    redirect_to root_path, alert: "Unauthorized Access!" unless current_user.admin?
  end

  def authenticate_manager!
    redirect_to root_path, alert: 'Unauthorized Access!' unless current_user.manager?
  end

  protected

  def after_sign_in_path_for(resource)
      if resource.admin?
        admin_root_path
      else
        root_path
      end
    end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:name, :email, :password, :password_confirmation, :current_password, attachment_attributes: [:id, :file, :attachable_id, :attachable_type])
    end
  end

end
