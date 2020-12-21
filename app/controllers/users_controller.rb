class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  def new 
    @user = User.new
  end

  def index
    @users = User.all
  end

  def edit 
    puts params[:id]
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:nitice] = "update sucsess"
      redirect_to articles_path
    else
    render "edit"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'succsess'
      redirect_to articles_path
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end