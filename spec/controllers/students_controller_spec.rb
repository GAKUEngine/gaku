require 'spec_helper'

describe StudentsController do

  let!(:student) { FactoryGirl.build_stubbed(:student) }

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
    it "redirects to the new page" do
      page.stub :save => true

      post :create
      created_student = Student.last
      response.should redirect_to(student_url(created_student))
    end
  end

  describe "PUT update" do
    pending "redirects to the page" do
      page.stub :update_attributes => true

      post :update, :id => student.id

      response.should redirect_to(student_url(student))
    end
  end
end