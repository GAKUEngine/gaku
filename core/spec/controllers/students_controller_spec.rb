require 'spec_helper'

describe Gaku::StudentsController do

  let(:student) { create(:student) }
  let(:country) { create(:country) }

  before do
    login_admin
  end

  describe "GET index" do
    it "should be successful" do
      gaku_get :index
      response.should be_success
    end
  end 

  describe "POST create" do
    it "redirects to the new student" do
      page.stub :save => true

      gaku_post :create, :name => student.name, :surname => student.surname
      response.should be_success
    end
  end

  describe "PUT update" do

    it "updates the student" do
      page.stub :update_attributes => true

      gaku_post :update, :id => student.id
      response.should redirect_to(student_url(student))
    end
  end

  describe "destroying a student" do

    it "sets the flash" do
      gaku_delete :destroy, :id => student
      controller.should set_the_flash
    end
  end

end