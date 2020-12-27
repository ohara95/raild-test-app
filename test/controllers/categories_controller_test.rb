require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")
  end

  test "インデックスを取得する必要があります" do
    get categories_url
    assert_response :success
  end

  # 新しいパスを取得し正常な応答を期待するテスト
  test "should get new" do
    get new_category_url
    assert_response :success
  end

  # test "should create category" do
  #   assert_difference('Category.count') do
  #     post categories_url, params: { category: {  } }
  #   end

  #   assert_redirected_to category_url(Category.last)
  # end

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
