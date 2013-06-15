require 'test_helper'

class CouplesControllerTest < ActionController::TestCase
  setup do
    @couple = couples(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:couples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create couple" do
    assert_difference('Couple.count') do
      post :create, couple: {  }
    end

    assert_redirected_to couple_path(assigns(:couple))
  end

  test "should show couple" do
    get :show, id: @couple
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @couple
    assert_response :success
  end

  test "should update couple" do
    put :update, id: @couple, couple: {  }
    assert_redirected_to couple_path(assigns(:couple))
  end

  test "should destroy couple" do
    assert_difference('Couple.count', -1) do
      delete :destroy, id: @couple
    end

    assert_redirected_to couples_path
  end
end
