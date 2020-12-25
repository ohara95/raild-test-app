class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :delete, :update]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    # article_paramsはprivateで定義している
    @article = Article.new(article_params)
    @article.user = current_user
    # @article = Article.new(params.require(:article).permit(:title, :description))
    # if @article.save
    # 保存できたら記事のパスにリダイレクト
    # flash[:notice] = "seccess!"
    #   redirect_to @article
    # else
    # 保存出来なかったら現在のページ(new)に止まる
    #   render "new"
    # end

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    # これでデフォルト値を入れてる？
    # @article.update(params.require(:article).permit(:title, :description))
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # viewでも使えるようにインスタンス変数にする
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

    # ログインユーザーと記事のユーザーが異なる場合に弾く
    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:alert] = "自分の記事のみを編集または削除できます"  
        redirect_to @article
      end
    end
end
