class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  protect_from_forgery with: :null_session
  def configure_permitted_parameters
  #サインアップ時は名前、メールアドレス、生年月日
    devise_parameter_sanitizer.permit(:sign_up,keys: [:name, :email, :birth_date])
  #サインイン時はメールアドレス
		devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  def after_sign_in_path_for(resource)
    if user_signed_in?
      #ユーザーがログインした場合はマイページに遷移
      user_path(resource)
    else
      #アドミンがログインした場合はユーザー一覧に遷移
      admin_users_path
    end
  end
  
  #ログアウト後はトップページへ
  def after_sign_out_path_for(resource)
    root_path
  end

#ransackによる検索機能
  def set_search
    @search = User.ransack(params[:q]) #ransackメソッド推奨
    @search_users = @search.result.page(params[:page])
  end

end
