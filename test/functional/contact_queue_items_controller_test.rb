require 'test_helper'

class ContactQueueItemsControllerTest < ActionController::TestCase
  setup do
    @contact_queue_item = contact_queue_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_queue_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_queue_item" do
    assert_difference('ContactQueueItem.count') do
      post :create, contact_queue_item: {  }
    end

    assert_redirected_to contact_queue_item_path(assigns(:contact_queue_item))
  end

  test "should show contact_queue_item" do
    get :show, id: @contact_queue_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact_queue_item
    assert_response :success
  end

  test "should update contact_queue_item" do
    put :update, id: @contact_queue_item, contact_queue_item: {  }
    assert_redirected_to contact_queue_item_path(assigns(:contact_queue_item))
  end

  test "should destroy contact_queue_item" do
    assert_difference('ContactQueueItem.count', -1) do
      delete :destroy, id: @contact_queue_item
    end

    assert_redirected_to contact_queue_items_path
  end
end
