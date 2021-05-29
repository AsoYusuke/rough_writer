class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:name, :email, :birth_date])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  def after_sign_in_path_for(resource)
    if user_signed_in?
      user_path(resource)
    else
      admin_users_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  def set_search
    #@search = Article.search(params[:q])
    @search = User.ransack(params[:q]) #ransackメソッド推奨
    @search_users = @search.result.page(params[:page])
  end

end
