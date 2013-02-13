require 'spec_helper'

describe Gaku::CoursesController do

  as_admin

  let(:course) { create(:course) }

  describe "GET #index" do
    it "is successful" do
      gaku_get :index
      response.should be_success
    end

    it "populates an array of courses" do
      gaku_get :index
      assigns(:courses).should eq [course]
    end

    it "renders the :index view" do
      gaku_get :index
      response.should render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested course to @course" do
      gaku_get :show, id: course
      assigns(:course).should eq course
    end

    it "renders the :show template" do
      gaku_get :show, id: course
      response.should render_template :show
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new course in the db" do
        expect{
          gaku_post :create, course: attributes_for(:course)
        }.to change(Gaku::Course, :count).by 1

        controller.should set_the_flash
      end
    end
  end

  describe "PUT #update" do

    it "locates the requested @course" do
      gaku_put :update, id: course, course: attributes_for(:course)
      assigns(:course).should eq(course)
    end

    context "valid attributes" do
      it "changes course's attributes" do
        gaku_put :update, id: course,course: attributes_for(:course, code: "Math2012")
        course.reload
        course.code.should eq("Math2012")

        controller.should set_the_flash
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the course" do
      @course = create(:course)
      expect{
        gaku_delete :destroy, id: @course
      }.to change(Gaku::Course, :count).by -1

      controller.should set_the_flash
    end
  end
end
