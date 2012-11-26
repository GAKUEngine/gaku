require 'spec_helper'

describe Gaku::Admin::SchoolsController do

  let(:school) { create(:school, :is_primary => true) }

  describe "GET #index" do
    it "is successful" do
      gaku_get :index
      response.should be_success
    end

    it "renders the :index view" do
      gaku_get :index
      response.should render_template :index
    end
  end 

  describe "GET #school_details" do
    it "is successful" do
      gaku_get :school_details
      response.should be_success
    end

    it "renders the :school_details view" do
      gaku_get :school_details
      response.should render_template :show
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new school in the db" do
        expect{
          gaku_post :create, school: attributes_for(:school)  
        }.to change(Gaku::School, :count).by 1
        
        controller.should set_the_flash
      end
    end
  end

  describe "PUT #update" do

    it "locates the requested @school" do
      gaku_put :update, id: school, school: attributes_for(:school) 
      assigns(:school).should eq(school)
    end

    context "valid attributes" do
      it "changes school's attributes" do
        gaku_put :update, id: school,school: attributes_for(:school, name: "AZ")
        school.reload
        school.name.should eq("AZ")

        controller.should set_the_flash
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the school" do
      school
      expect{
        gaku_delete :destroy, id: school
      }.to change(Gaku::School, :count).by -1

      controller.should set_the_flash
    end
  end

end