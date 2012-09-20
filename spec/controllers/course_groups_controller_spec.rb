require 'spec_helper'

describe CourseGroupsController do

  let(:course_group) { FactoryGirl.create(:course_group) }

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
    it "should be successful" do
      page.stub :save => true

      post :create
      response.should be_success
    end
  end

  describe "PUT update" do

    it "redirects to the course group" do
      page.stub :update_attributes => true

      post :update, :id => course_group.id
      response.should redirect_to(course_group_url(course_group))
    end
  end

  describe "destroying a course group" do

    it "sets the flash" do
      delete :destroy, :id => course_group
      controller.should set_the_flash
    end
  end
end