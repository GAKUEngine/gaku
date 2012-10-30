require 'spec_helper'

describe Gaku::CourseGroupsController do

  let(:course_group) { create(:course_group) }

  before do
    login_admin
  end

  describe "GET index" do
    it "should be successful" do
      gaku_get :index
      response.should be_success
    end
  end 

  describe "PUT update" do

    it "redirects to the course group" do
      page.stub :update_attributes => true

      gaku_post :update, :id => course_group.id
      response.should redirect_to(course_group_url(course_group))
    end
  end

  describe "destroying a course group" do

    it "sets the flash" do
      gaku_delete :destroy, :id => course_group
      controller.should set_the_flash.now
    end
  end
end