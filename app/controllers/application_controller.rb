class ApplicationController < ActionController::Base

  # これを書くとviewでも使えるようになる
  helper_method :current_user, :logged_in?

  def current_user
    # sessionIdの有無判定
    # if session[:user_id]
      # あったらuserさがす
      # if User.find(session[:user_id])
        # currentUserがいたらcurrentUserを返す
        # @current_user = User.find(session[:user_id])
        # currentUserがいなかったらusrTableにクエリを実行してユーザーを検索して返す
    # end
    # 1行でも書ける
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # ログインユーザーの有無を確認
  def logged_in?
    !!current_user
  end


end
