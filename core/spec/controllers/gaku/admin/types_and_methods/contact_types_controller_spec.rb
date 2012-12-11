require 'spec_helper'

describe Gaku::Admin::ContactTypesController do

  let(:contact_type) { create(:contact_type) }

  describe "GET #index" do
    it "is successful" do
      gaku_js_get :index
      response.should be_success
    end

    it "populates an array of contact types" do
      gaku_js_get :index
      assigns(:contact_types).should eq [contact_type]
    end

    it "renders the :index view" do
      gaku_js_get :index
      response.should render_template :index
    end
  end 

  describe 'GET #new' do
    it "assigns a new contact_type to @contact_type" do
      gaku_js_get :new, contact_type_id: contact_type.id
      assigns(:contact_type).should be_a_new(Gaku::ContactType)
    end

    it "renders the :new template" do
        gaku_js_get :new, contact_type_id: contact_type.id
        response.should render_template :new
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
    context "with invalid attributes" do
      it "does not save the new contact type in the db" do
          expect{
            gaku_js_post :create, contact_type: {name: ''}  
          }.to_not change(Gaku::ContactType, :count)
      end
    end
  end

  describe 'GET #edit' do
    it "locates the requested contact_type" do
      gaku_js_get :edit, id: contact_type
      assigns(:contact_type).should eq(contact_type)
    end

    it "renders the :edit template" do
        gaku_js_get :edit, id: contact_type
        response.should render_template :edit
    end
  end

  describe "PUT #update" do
    it "locates the requested @contact_type" do
      gaku_put :update, id: contact_type, 
                        contact_type: attributes_for(:contact_type)
      assigns(:contact_type).should eq(contact_type)
    end

    context "valid attributes" do
      it "changes contact type's attributes" do
        gaku_put :update, id: contact_type,
                          contact_type: attributes_for(:contact_type, name: "Phone")
        contact_type.reload
        contact_type.name.should eq("Phone")

        controller.should set_the_flash
      end
    end

    context "invalid attributes" do
      it "does not change contact type's attributes" do
        gaku_js_put :update, id: contact_type, 
                              contact_type: attributes_for(:contact_type, name: "")
        contact_type.reload
        contact_type.name.should_not eq("")
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