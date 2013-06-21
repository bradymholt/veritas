require 'test_helper'

class FamiliesControllerTest < ActionController::TestCase
  setup do
    @family = families(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:families)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create family" do
    assert_difference('Family.count') do
      post :create, family: {  }
    end

    assert_redirected_to family_path(assigns(:family))
  end

  test "should show family" do
    get :show, id: @family
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @family
    assert_response :success
  end

  test "should update family" do
    put :update, id: @family, couple: {  }
    assert_redirected_to family_path(assigns(:family))
  end

  test "should destroy family" do
    assert_difference('Family.count', -1) do
      delete :destroy, id: @family
    end

    assert_redirected_to families_path
  end
end
