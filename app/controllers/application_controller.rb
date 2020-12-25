class ApplicationController < ActionController::Base

  # これを書くとviewでも使えるようになる
  helper_method :current_user, :logged_in?

  def current_user
    # sessionIdがあったらuserさがす
    # currentUserがいたらcurrentUserを返す
    # currentUserがいなかったらuserTableにクエリを実行してユーザーを検索して返す
    # 1行でも書ける
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # ログインユーザーの有無を確認
  def logged_in?
    !!current_user
  end

  # ログインユーザーしか処理出来ない部分を弾く
  def require_user
    if !logged_in?
      flash[:alert] = "アクションを実行するには、ログインする必要があります"
      redirect_to login_path
    end
  end

end
