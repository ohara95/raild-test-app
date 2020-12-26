class SessionsController < ApplicationController

  def new
  end

  def create
    # viewで使わないのでインスタンス変数にはしない
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # sessionにuserIdを格納
      session[:user_id] = user.id
      flash[:notice] = "ログイン成功！"
      redirect_to user
    else
      flash.now[:alert] = "ログイン情報に問題がありました"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウト"
    redirect_to root_path
  end

end