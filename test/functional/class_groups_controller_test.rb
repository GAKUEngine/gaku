require 'test_helper'

class ClassGroupsControllerTest < ActionController::TestCase
  setup do
    @class_group = class_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:class_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create class_group" do
    assert_difference('ClassGroup.count') do
      post :create, class_group: @class_group.attributes
    end

    assert_redirected_to class_group_path(assigns(:class_group))
  end

  test "should show class_group" do
    get :show, id: @class_group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @class_group.to_param
    assert_response :success
  end

  test "should update class_group" do
    put :update, id: @class_group.to_param, class_group: @class_group.attributes
    assert_redirected_to class_group_path(assigns(:class_group))
  end

  test "should destroy class_group" do
    assert_difference('ClassGroup.count', -1) do
      delete :destroy, id: @class_group.to_param
    end

    assert_redirected_to class_groups_path
  end
end
