class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 登入相關的程式可以移入 SessionsHelper
  include SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def login_required
     unless logged_in?
        redirect_to "/login"
     end
  end

  def admin_required
     unless current_user.is_admin
        redirect_to root_path, alert: "您無權檢視該頁面，請先以管理者帳號登入！"
     end
  end

  def logged_in?
    !current_user.nil?
  end

  private
  def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  helper_method :current_user

end
