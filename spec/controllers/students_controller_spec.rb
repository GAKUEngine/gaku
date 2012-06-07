require 'spec_helper'

describe StudentsController do

  let(:student) { FactoryGirl.create(:student) }

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
    it "redirects to the new page" do
      page.stub :save => true

      post :create
      response.should redirect_to(student_url(Student.last))
    end
  end

  describe "PUT update" do

    it "redirects to the page" do
      page.stub :update_attributes => true

      post :update, :id => student.id
      response.should redirect_to(student_url(student))
    end
  end

  describe "destroying a student" do

    it "doesn't set the flash on xhr requests'" do
      xhr :delete, :destroy, :id => student
      controller.should_not set_the_flash
    end

    it "sets the flash" do
      delete :destroy, :id => student
      controller.should set_the_flash
    end
  end

end