require 'spec_helper'

describe CoursesController do

  let(:course) { FactoryGirl.create(:course) }

  before do
    login_admin
  end

  describe "GET :index	" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end 

  describe "POST create" do
    it "redirects to the new course" do
      page.stub :save => true

      post :create
      response.should redirect_to(course_url(Course.last))
    end
  end

  describe "PUT update" do

    it "redirects to the course" do
      page.stub :update_attributes => true

      post :update, :id => course.id
      response.should redirect_to(course_url(course))
    end
  end

  describe "destroying a course" do

    it "doesn't set the flash on xhr requests'" do
      xhr :delete, :destroy, :id => course
      controller.should_not set_the_flash
    end

    it "sets the flash" do
      delete :destroy, :id => course
      controller.should set_the_flash
    end
  end
end