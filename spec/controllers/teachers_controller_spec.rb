require 'spec_helper'

describe TeachersController do

  let!(:teacher) { FactoryGirl.build_stubbed(:teacher) }

  before do
    login_admin
  end

  it "should have a current_user" do
    subject.current_user.should_not be_nil
  end

  describe "GET :index	" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end 

  describe "POST create" do
    it "redirects to the new teacher" do
      page.stub :save => true

      post :create
      created_teacher = Teacher.last
      response.should redirect_to(teacher_url(created_teacher))
    end
  end
end