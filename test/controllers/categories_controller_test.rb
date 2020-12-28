require 'test_helper'
# コントローラーのアクションが、リクエストや期待される結果（レスポンス、場合によってはHTMLビュー）を
# どう扱っているかをテスト,個々の機能をテスト -> 機能テスト
# HTTPリクエストを擬似的に作成
class CategoriesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @category = Category.create(name: "Sports")
    @admin_user = User.create(username:"johndoe",email:"johndoe@example.com",password:"password",admin:true)
  end

  test "インデックスを取得する必要があります" do
    get categories_url
    assert_response :success
  end

  # 新しいパスを取得し正常な応答を期待するテスト
  test "should get new" do
    # test_helperに定義されている
    sign_in_as(@admin_user)
    get new_category_url
    assert_response :success
  end

  test "カテゴリを作成する必要があります" do
    sign_in_as(@admin_user)
    # カテゴリー数の変化チェック
    assert_difference('Category.count',1) do
      post categories_url, params: { category: { name:"Travel" } }
    end
    assert_redirected_to category_url(Category.last)
  end

  test "管理者でない場合はカテゴリを作成してはいけない" do
    # カテゴリー数の変化チェック
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: "Travel" } }
    end
    assert_redirected_to categories_url
  end

  test "カテゴリを表示する必要があります" do
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "カテゴリを更新する必要があります" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "カテゴリを削除する必要があります" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end
