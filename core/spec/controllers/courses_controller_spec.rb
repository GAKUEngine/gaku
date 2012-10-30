require 'spec_helper'

describe Gaku::CoursesController do

  let(:course) { create(:course) }

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
    subject { gaku_post :create, :course => { :code => "Fall2012" } }

    it "redirects to course_url(@course)" do
      subject.should redirect_to(course_url(assigns(:course)))
    end

    it "redirects_to :action => :show" do
      subject.should redirect_to :action => :show,
                                 :id => assigns(:course).id
    end

    it "redirects_to(@course)" do
      subject.should redirect_to(assigns(:course))
    end

    it "redirects_to /courses/:id" do
      subject.should redirect_to("/courses/#{assigns(:course).id}")
    end
  end

  describe "PUT update" do

    it "redirects to the course" do
      page.stub :update_attributes => true

      gaku_post :update, :id => course.id
      response.should redirect_to(course_url(course))
    end
  end
end