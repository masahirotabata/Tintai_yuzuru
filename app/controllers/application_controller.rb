class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource)
  public_customer_path(current_customer.id)
  end

  def after_sign_out_path_for(resource)
  root_path # ログアウト後に遷移するpathを設定
  end
  
  def require_login!
    if session[:customer_email].nil?
    redirect_to login_path
    end
  end
  Refile.secret_key = '9953169e74f1595b3dff1c45e9c8275784e7f1bf81d3fb38f0a4e321807531492c18d93cf192e217972898440fa8ddce9b06c1c7f2a934d2223aa13992e1dc26'
# before_action :authenticate_customer!,except: [:top,:about]

  add_flash_types :success, :info, :warning, :danger


  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up,keys:[:email, :first_name, :last_name, :password, :password_confirmation, :first_name_kana, :last_name_kana, :postal_code, :address, :tel])
  end
end
