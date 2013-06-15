require 'test_helper'

class MobilesControllerTest < ActionController::TestCase
  setup do
    @mobile = mobiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mobiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mobile" do
    assert_difference('Mobile.count') do
      post :create, mobile: {  }
    end

    assert_redirected_to mobile_path(assigns(:mobile))
  end

  test "should show mobile" do
    get :show, id: @mobile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mobile
    assert_response :success
  end

  test "should update mobile" do
    put :update, id: @mobile, mobile: {  }
    assert_redirected_to mobile_path(assigns(:mobile))
  end

  test "should destroy mobile" do
    assert_difference('Mobile.count', -1) do
      delete :destroy, id: @mobile
    end

    assert_redirected_to mobiles_path
  end
end
