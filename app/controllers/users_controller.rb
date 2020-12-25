class UsersController < ApplicationController

  before_action :set_user, only:[:show, :edit, :update, :destroy]
  # ログインしてない状態でprofileを編集出来ないようにする
  before_action :require_user, only:[:update, :edit]
  # 違うユーザー編集を出来ないようにする
  before_action :require_same_user, only:[:edit,:update, :destroy]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new 
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def edit 
  end

  def update 
    if @user.update(user_params)
      flash[:notice] = "update sucsess"
      redirect_to @user
    else
    render "edit"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'succsess'
      redirect_to articles_path
    else
      render "new"
    end
  end

  def destroy
    @user.destroy
    # 消したらidがなくなってエラーになるのを防ぐためにnilを入れる
    # adminで削除した場合にログアウトされて欲しくないからloginユーザーの場合のみログアウト
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "アカウントと関連するすべての記事が正常に削除されました"
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "自分のアカウントのみを編集か削除できます"
      redirect_to @user
    end
  end
end