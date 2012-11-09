require 'spec_helper'

describe Gaku::CourseGroupsController do

  let(:course_group) { create(:course_group) }

  describe "GET #index" do
    it "is successful" do
      gaku_get :index
      response.should be_success
    end

    it "populates an array of course group" do
      gaku_get :index
      assigns(:course_groups).should eq [course_group]
    end

    it "renders the :index view" do
      gaku_get :index
      response.should render_template :index
    end
  end 

  describe 'GET #show' do
    it "assigns the requested course group to @course_group" do
      gaku_get :show, id: course_group
      assigns(:course_group).should eq course_group
    end

    it "renders the :show template" do
      gaku_get :show, id: course_group
      response.should render_template :show
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new course group in the db" do
        expect{
          gaku_post :create, course_group: attributes_for(:course_group)  
        }.to change(Gaku::CourseGroup, :count).by 1
        
        controller.should set_the_flash
      end
    end
  end

  describe "PUT #update" do

    it "locates the requested @course_group" do
      gaku_put :update, id: course_group, course_group: attributes_for(:course_group) 
      assigns(:course_group).should eq(course_group)
    end

    context "valid attributes" do
      it "changes course group's attributes" do
        gaku_put :update, id: course_group,course_group: attributes_for(:course_group, name: "AZ")
        course_group.reload
        course_group.name.should eq("AZ")

        controller.should set_the_flash
      end
    end
  end

  describe "DELETE #destroy" do
    pending "deletes the course group" do   
      gaku_delete :destroy, :id => course_group
      expect(course_group.is_deleted).to eq true
      controller.should set_the_flash  
    end
  end
end