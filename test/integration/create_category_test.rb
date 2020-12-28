require 'test_helper'
# カテゴリを作成するビジネスプロセス全体のテスト
# 複数のコントローラーにまたがって、ユーザーの実際の操作を追跡する用途で利用するテスト -> 統合テスト
class CreateCategoryTest < ActionDispatch::IntegrationTest

  test "カテゴリー作成から新しいカテゴリーを取得" do
    get "/categories/new"
    assert_response :success
    # 特定の処理の前後における数値の増減をテスト
    assert_difference "Category.count", 1 do
      post categories_path, params:{category:{name:"Sports"}}
      assert_response :redirect
    end
    # POSTリクエストを送信した結果を見て、指定されたリダイレクト先に移動するメソッド
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "新しいカテゴリフォームを取得し、無効なカテゴリの送信を拒否します" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " "} }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
