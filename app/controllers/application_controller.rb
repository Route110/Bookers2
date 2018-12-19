class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

def after_sign_in_path_for(resource)
    user_path(resource)
end

Refile.secret_key = '5a1f18f97053dbdb31aff24c0481a6e8027ef3e52521a481d158eacadccc9427a2be6a0c66e3dbdd45659de33b226de59fbda9475427b276127facfaf373b3df'

  protected
  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email,:password,:password_confirmation])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email, :password])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password])
  end
end
