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
    # リクエストのパラメータを使ってarticleのデータを作る
    @article = Article.new(article_params)
    @article.user = current_user

    respond_to do |format|
      if @article.save
        # 保存できたら記事のパスにリダイレクト
        format.html { redirect_to @article, notice: '記事が正常に作成されました' }
        format.json { render :show, status: :created, location: @article }
      else
        # 保存出来なかったら現在のページ(new)に止まる
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      # データの更新
      if @article.update(article_params)
        format.html { redirect_to @article, notice: '記事が正常に更新されました' }
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
      format.html { redirect_to articles_url, notice: '記事は正常に破棄されました' }
      format.json { head :no_content }
    end
  end

  private
    # viewでも使えるようにインスタンス変数にする
    def set_article
      # レコード毎の表示画面を動的に生成(atricles/:id) 
      @article = Article.find(params[:id])
    end

    # DB更新をする際に不要なパラメーターを取り除く
    def article_params
      # paramsはクライアントが送信したデータ
      # articleのtitleとdescriptionのみ受け取る(更新を許可) -> セキュリティ対策
      # memo category_ids:[]と:category_ids[]の違いは？
      params.require(:article).permit(:title, :description, category_ids:[])
    end

    # ログインユーザーと記事のユーザーが異なる場合に弾く
    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:alert] = "自分の記事のみを編集または削除できます"  
        redirect_to @article
      end
    end
end
