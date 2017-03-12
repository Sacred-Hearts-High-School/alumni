class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:session][:account],params[:session][:password])
    if user
      log_in user
      if user.is_admin
        redirect_to members_path
      elsif
        redirect_to root_path
      end
    else
      flash.now[:error]="帳號或密碼錯誤！"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to "/login"
  end
  
end
