require 'spec_helper'

describe Gaku::Admin::SchoolsController do

  let(:school) { create(:school, :is_primary => true) }

  describe "GET #index" do
    it "is successful" do
      gaku_js_get :index
      response.should be_success
    end

    it "populates an array of schools" do
      gaku_js_get :index
      assigns(:schools).should eq [school]
    end

    it "renders the :index view" do
      gaku_js_get :index
      response.should render_template :index
    end
  end 

  describe "GET #school_details" do
    it "is successful" do
      gaku_get :school_details
      response.should be_success
    end

    it "assigns the requested school to @school" do
      gaku_js_get :show, id: school
      assigns(:school).should eq school
    end

    it "renders the :school_details view" do
      gaku_get :school_details
      response.should render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new school to @school" do
      gaku_js_get :new, school_id: school.id
      assigns(:school).should be_a_new(Gaku::School)
    end

    it "renders the :new template" do
        gaku_js_get :new, school_id: school.id
        response.should render_template :new
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
    context "with invalid attributes" do
      it "does not save the new school in the db" do
        expect{
          gaku_js_post :create, school: {name: ''}  
        }.to_not change(Gaku::School, :count)
      end
    end
  end

  describe 'GET #edit' do
    it "locates the requested school" do
      gaku_js_get :edit, id: school
      assigns(:school).should eq(school)
    end

    it "renders the :edit template" do
        gaku_js_get :edit, id: school
        response.should render_template :edit
    end
  end

  describe "PUT #update" do
    it "locates the requested @school" do
      gaku_put :update, id: school, school: attributes_for(:school) 
      assigns(:school).should eq(school)
    end

    context "valid attributes" do
      it "changes school's attributes" do
        gaku_put :update, id: school,school: attributes_for(:school, name: "UE Varna")
        school.reload
        school.name.should eq("UE Varna")

        controller.should set_the_flash
      end
    end
    context "invalid attributes" do
      it "does not change school's attributes" do
        gaku_js_put :update, id: school, 
                              school: attributes_for(:school, name: "")
        school.reload
        school.name.should_not eq("")
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