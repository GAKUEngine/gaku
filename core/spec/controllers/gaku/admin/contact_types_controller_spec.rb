require 'spec_helper'

describe Gaku::Admin::ContactTypesController do

  let(:contact_type) { create (:contact_type) }
  
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
      it "saves the new contact type in the db" do
        expect{
          gaku_post :create, contact_type: attributes_for(:contact_type)  
        }.to change(Gaku::ContactType, :count).by 1
        
        controller.should set_the_flash
      end
    end
  end

  describe "PUT #update" do

    it "locates the requested @contact_type" do
      gaku_put :update, id: contact_type, contact_type: attributes_for(:contact_type) 
      assigns(:contact_type).should eq(contact_type)
    end

    context "valid attributes" do
      it "changes contact type's attributes" do
        gaku_put :update, id: contact_type,contact_type: attributes_for(:contact_type, name: "AZ")
        contact_type.reload
        contact_type.name.should eq("AZ")

        controller.should set_the_flash
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the contact type" do
      contact_type
      expect{
        gaku_delete :destroy, id: contact_type
      }.to change(Gaku::ContactType, :count).by -1

      controller.should set_the_flash
    end
  end

end