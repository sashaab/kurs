require 'test_helper'

class GoodsControllerTest < ActionController::TestCase
  setup do
    @good = goods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create good" do
    assert_difference('Good.count') do
      post :create, good: { article: @good.article, base_price: @good.base_price, current_price: @good.current_price, full_description: @good.full_description, list_id_images: @good.list_id_images, minimum_quantity: @good.minimum_quantity, quantity_in_stock: @good.quantity_in_stock, short_description: @good.short_description, title: @good.title }
    end

    assert_redirected_to good_path(assigns(:good))
  end

  test "should show good" do
    get :show, id: @good
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @good
    assert_response :success
  end

  test "should update good" do
    patch :update, id: @good, good: { article: @good.article, base_price: @good.base_price, current_price: @good.current_price, full_description: @good.full_description, list_id_images: @good.list_id_images, minimum_quantity: @good.minimum_quantity, quantity_in_stock: @good.quantity_in_stock, short_description: @good.short_description, title: @good.title }
    assert_redirected_to good_path(assigns(:good))
  end

  test "should destroy good" do
    assert_difference('Good.count', -1) do
      delete :destroy, id: @good
    end

    assert_redirected_to goods_path
  end
end
