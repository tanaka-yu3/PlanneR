class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :config_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  ##ログイン情報追加
  def config_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys:
      [:image,
       :family_name,
       :last_name,
       :family_name_kana,
       :last_name_kana,
       :phone_number,
       :postcode,
       :address])
    devise_parameter_sanitizer.permit(:account_update, keys:
      [:image,
       :family_name,
       :last_name,
       :family_name_kana,
       :last_name_kana,
       :phone_number,
       :postcode,
       :address,
       :bank_name,
       :bank_account_kind,
       :bank_branch_code,
       :bank_account_number
     ])
  end
end