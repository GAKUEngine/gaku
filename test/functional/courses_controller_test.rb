require 'test_helper'

class SchoolClassesControllerTest < ActionController::TestCase
  setup do
    @course = courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course" do
    assert_difference('SchoolClass.count') do
      post :create, course: @course.attributes
    end

    assert_redirected_to course_path(assigns(:course))
  end

  test "should show course" do
    get :show, id: @course.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course.to_param
    assert_response :success
  end

  test "should update course" do
    put :update, id: @course.to_param, course: @course.attributes
    assert_redirected_to course_path(assigns(:course))
  end

  test "should destroy course" do
    assert_difference('SchoolClass.count', -1) do
      delete :destroy, id: @course.to_param
    end

    assert_redirected_to courses_path
  end
end
