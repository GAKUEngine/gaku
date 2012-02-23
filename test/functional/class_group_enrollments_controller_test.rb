require 'test_helper'

class ClassGroupEnrollmentsControllerTest < ActionController::TestCase
  setup do
    @class_group_enrollment = class_group_enrollments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:class_group_enrollments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create class_group_enrollment" do
    assert_difference('ClassGroupEnrollment.count') do
      post :create, class_group_enrollment: @class_group_enrollment.attributes
    end

    assert_redirected_to class_group_enrollment_path(assigns(:class_group_enrollment))
  end

  test "should show class_group_enrollment" do
    get :show, id: @class_group_enrollment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @class_group_enrollment.to_param
    assert_response :success
  end

  test "should update class_group_enrollment" do
    put :update, id: @class_group_enrollment.to_param, class_group_enrollment: @class_group_enrollment.attributes
    assert_redirected_to class_group_enrollment_path(assigns(:class_group_enrollment))
  end

  test "should destroy class_group_enrollment" do
    assert_difference('ClassGroupEnrollment.count', -1) do
      delete :destroy, id: @class_group_enrollment.to_param
    end

    assert_redirected_to class_group_enrollments_path
  end
end
