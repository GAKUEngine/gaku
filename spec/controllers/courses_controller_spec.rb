require 'spec_helper'

describe CoursesController do

  let(:course) { FactoryGirl.build_stubbed(:course) }

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
end