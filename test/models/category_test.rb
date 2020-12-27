require "test_helper"

# assert -> 有効
# テストに付随するバリデーション必要(model)
class CategoryTest < ActiveSupport::TestCase
  # 各テストが行われる前に実行される
  # 重複するものを書く
  def setup
    # 1テスト1インスタンス変数だから重複する
    # カテゴリが有効かどうか調べるためにオブジェクトを作成
    @category = Category.new(name: "Sports")
  end

  # カテゴリインスタンス変数、カテゴリオブジェクト作成
  test "カテゴリは有効である必要がある" do
    assert @category.valid?
  end

  test "名前が存在する必要があります" do
    # @category = Category.new(name:"")
    # 上と同じ意味 setupに書いたから短く書ける
    @category.name = ""
    # 有効かどうかチェック
    assert_not @category.valid?
  end

  test "名前は一意である必要があります" do
    @category.save
    @category2 = Category.new(name: "Sports")
    assert_not @category2.valid?
  end

  test "名前は長すぎてはいけません" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "名前は短すぎてはいけません" do
    @category.name = "aa"
    assert_not @category.valid?
  end
end