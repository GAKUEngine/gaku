require 'spec_helper'

describe Gaku::Admin::EnrollmentStatusTypesController do

  let(:enrollment_status_type) { create (:enrollment_status_type) }
  
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

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new enrollment status type in the db" do
        expect{
          gaku_post :create, enrollment_status_type: attributes_for(:enrollment_status_type)  
        }.to change(Gaku::EnrollmentStatusType, :count).by 1
        
        controller.should set_the_flash
      end
    end
  end

  describe "PUT #update" do

    it "locates the requested @enrollment_status_type" do
      gaku_put :update, id: enrollment_status_type, enrollment_status_type: attributes_for(:enrollment_status_type) 
      assigns(:enrollment_status_type).should eq(enrollment_status_type)
    end

    context "valid attributes" do
      it "changes enrollment status type's attributes" do
        gaku_put :update, id: enrollment_status_type,enrollment_status_type: attributes_for(:enrollment_status_type, name: "AZ")
        enrollment_status_type.reload
        enrollment_status_type.name.should eq("AZ")

        controller.should set_the_flash
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