require 'spec_helper'

describe Gaku::SyllabusesController do

  let(:syllabus) { create(:syllabus) }

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

  describe 'GET #show' do
    it "assigns the requested syllabus to @syllabus" do
      gaku_js_get :show, id: syllabus
      assigns(:syllabus).should eq syllabus
    end

    it "renders the :show template" do
      gaku_js_get :show, id: syllabus
      response.should render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new syllabus to @syllabus" do
      gaku_js_get :new
      assigns(:syllabus).should be_a_new(Gaku::Syllabus)
    end

    it "renders the :new template" do
      gaku_js_get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new syllabus in the db" do
        expect{
          gaku_js_post :create, syllabus: attributes_for(:syllabus)  
        }.to change(Gaku::Syllabus, :count).by 1
        
      end
    end
    context "with invalid attributes" do
      it "does not save the new syllabus in the db" do
        expect{
          gaku_js_post :create, syllabus: {name: ''}  
        }.to_not change(Gaku::Syllabus, :count)
      end
    end
  end

  describe "PUT #update" do

    it "locates the requested @syllabus" do
      gaku_put :update, id: syllabus, syllabus: attributes_for(:syllabus) 
      assigns(:syllabus).should eq(syllabus)
    end

    context "valid attributes" do
      it "changes syllabus's attributes" do
        gaku_put :update, id: syllabus,syllabus: attributes_for(:syllabus, name: "AZ")
        syllabus.reload
        syllabus.name.should eq("AZ")

        controller.should set_the_flash
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the syllabus" do
      @syllabus = create(:syllabus)
      expect{
        gaku_delete :destroy, id: @syllabus
      }.to change(Gaku::Syllabus, :count).by -1

      controller.should set_the_flash
    end
  end

end
