require 'spec_helper'

describe Gaku::Admin::EnrollmentStatusTypesController do

  let(:enrollment_status_type) { create (:enrollment_status_type) }
  
  describe "GET #index" do
    it "is successful" do
      gaku_js_get :index
      response.should be_success
    end

    it "populates an array of enrollment status types" do
      gaku_js_get :index
      assigns(:enrollment_status_types).should eq [enrollment_status_type]
    end

    it "renders the :index view" do
      gaku_js_get :index
      response.should render_template :index
    end
  end 

  describe 'GET #new' do
    it "assigns a new enrollment_status_type to @enrollment_status_type" do
      gaku_js_get :new, enrollment_status_type_id: enrollment_status_type.id
      assigns(:enrollment_status_type).should be_a_new(Gaku::EnrollmentStatusType)
    end

    it "renders the :new template" do
        gaku_js_get :new, enrollment_status_type_id: enrollment_status_type.id
        response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new enrollment status type in the db" do
        expect{
          gaku_post :create, enrollment_status_type: attributes_for(:enrollment_status_type)  
        }.to change(Gaku::EnrollmentStatusType, :count).by 1
        
        controller.should set_the_flash
      end
    end
    context "with invalid attributes" do
      it "does not save the new enrollment status type in the db" do
          expect{
            gaku_js_post :create, enrollment_status_type: {name: ''}  
          }.to_not change(Gaku::EnrollmentStatusType, :count)
      end
    end
  end

  describe 'GET #edit' do
    it "locates the requested enrollment_status_type" do
      gaku_js_get :edit, id: enrollment_status_type
      assigns(:enrollment_status_type).should eq(enrollment_status_type)
    end

    it "renders the :edit template" do
        gaku_js_get :edit, id: enrollment_status_type
        response.should render_template :edit
    end
  end

  describe "PUT #update" do

    it "locates the requested @enrollment_status_type" do
      gaku_put :update, id: enrollment_status_type, enrollment_status_type: attributes_for(:enrollment_status_type) 
      assigns(:enrollment_status_type).should eq(enrollment_status_type)
    end

    context "valid attributes" do
      it "changes enrollment status type's attributes" do
        gaku_put :update, id: enrollment_status_type,enrollment_status_type: attributes_for(:enrollment_status_type, name: "Admitted")
        enrollment_status_type.reload
        enrollment_status_type.name.should eq("Admitted")

        controller.should set_the_flash
      end
    end

    context "invalid attributes" do
      it "doesn\'t changes enrollment status type\'s attributes" do
        gaku_js_put :update, id: enrollment_status_type,enrollment_status_type: attributes_for(:enrollment_status_type, name: "")
        enrollment_status_type.reload
        enrollment_status_type.name.should_not eq("")

      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the enrollment status type" do
      enrollment_status_type
      expect{
        gaku_delete :destroy, id: enrollment_status_type
      }.to change(Gaku::EnrollmentStatusType, :count).by -1

      controller.should set_the_flash
    end
  end

end