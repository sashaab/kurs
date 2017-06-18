require 'test_helper'

class GoodOrdersControllerTest < ActionController::TestCase
  setup do
    @good_order = good_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:good_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create good_order" do
    assert_difference('GoodOrder.count') do
      post :create, good_order: { digit: @good_order.digit, good_id: @good_order.good_id, order_id: @good_order.order_id }
    end

    assert_redirected_to good_order_path(assigns(:good_order))
  end

  test "should show good_order" do
    get :show, id: @good_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @good_order
    assert_response :success
  end

  test "should update good_order" do
    patch :update, id: @good_order, good_order: { digit: @good_order.digit, good_id: @good_order.good_id, order_id: @good_order.order_id }
    assert_redirected_to good_order_path(assigns(:good_order))
  end

  test "should destroy good_order" do
    assert_difference('GoodOrder.count', -1) do
      delete :destroy, id: @good_order
    end

    assert_redirected_to good_orders_path
  end
end
