class CategoriesController < ApplicationController

  before_action :require_admin, except:[:index,:show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "カテゴリ名が正常に更新されました"
      redirect_to @category
    else
      render "edit"
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save 
      flash[:notice] = "カテゴリー作成成功！"
      redirect_to @category
    else
      # 注:文字列！
      render "new"
    end
  end

  private

  # before_actionに記載不要
  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "管理者のみ実行できます"
      redirect_to categories_path
    end
  end

end