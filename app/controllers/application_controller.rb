class ApplicationController < ActionController::Base
	# before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?
	#デバイス機能実行前にconfigure_permitted_parametersの実行をする。
  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  #sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  def after_sign_out_path_for(resource)
    root_path(resource)
  end


  protected
  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    #sign_upの際にnameのデータ操作を許。追加したカラム。
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

end
