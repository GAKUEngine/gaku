require 'spec_helper'

describe Gaku::Admin::AdmissionMethodsController do

  let(:admission_method) { create(:admission_method) }

  describe "GET #index" do
    it "is successful" do
      gaku_get :index
      response.should be_success
    end

    it "populates an array of admission_methods" do
      gaku_get :index
      assigns(:admission_methods).should eq [admission_method]
    end

    it "renders the :index view" do
      gaku_get :index
      response.should render_template :index
    end
  end

    describe 'GET #show' do
    it "assigns the requested admission_method to @admission_method" do
      gaku_get :show, id: admission_method
      assigns(:admission_method).should eq admission_method
    end

    it "renders the :show template" do
      gaku_get :show, id: admission_method
      response.should render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new admission_method to @admission_method" do
      gaku_xhr_get :new
      assigns(:admission_method).should be_a_new(Gaku::AdmissionMethod)
    end

    it "renders the :new template" do
      gaku_xhr_get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new admission method in the db" do
        expect{
          gaku_xhr_post :create, admission_method: attributes_for(:admission_method)  
        }.to change(Gaku::AdmissionMethod, :count).by 1
      end
    end
    context "with invalid attributes" do
      it "does not save the new admission method in the db" do
        expect{
          gaku_xhr_post :create, admission_method: {name: ''}  
        }.to_not change(Gaku::AdmissionMethod, :count)
      end
    end
  end

  describe "PUT #update" do

    it "locates the requested @admission_method" do
      gaku_put :update, id: admission_method, admission_method: attributes_for(:admission_method) 
      assigns(:admission_method).should eq(admission_method)
    end

    context "valid attributes" do
      it "changes admission metod's attributes" do
        gaku_put :update, id: admission_method, admission_method: attributes_for(:admission_method, name: "Regular Admissions")
        admission_method.reload
        admission_method.name.should eq("Regular Admissions")

        controller.should set_the_flash
      end
    end

    context "invalid attributes" do
      it "does not change admission_method's attributes" do
        gaku_xhr_put :update, id: admission_method, admission_method: attributes_for(:admission_method, name: "")
        admission_method.reload
        admission_method.name.should_not eq("")
      end
    end
  end


  describe "DELETE #destroy" do
    it "deletes the admission method" do
      admission_method
      expect{
        gaku_delete :destroy, id: admission_method
      }.to change(Gaku::AdmissionMethod, :count).by -1

      controller.should set_the_flash
    end
  end
end