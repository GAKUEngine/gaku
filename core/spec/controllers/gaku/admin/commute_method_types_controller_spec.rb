require 'spec_helper'

describe Gaku::Admin::CommuteMethodTypesController do

  let(:commute_method_type) { create(:commute_method_type) }

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
      it "saves the new commute method type in the db" do
        expect{
          gaku_post :create, commute_method_type: attributes_for(:commute_method_type)  
        }.to change(Gaku::CommuteMethodType, :count).by 1
        
        controller.should set_the_flash
      end
    end
  end

  describe "PUT #update" do

    it "locates the requested @commute_method_type" do
      gaku_put :update, id: commute_method_type, commute_method_type: attributes_for(:commute_method_type) 
      assigns(:commute_method_type).should eq(commute_method_type)
    end

    context "valid attributes" do
      it "changes commute method type's attributes" do
        gaku_put :update, id: commute_method_type,commute_method_type: attributes_for(:commute_method_type, name: "AZ")
        commute_method_type.reload
        commute_method_type.name.should eq("AZ")

        controller.should set_the_flash
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the commute method type" do
      @commute_method_type = create(:commute_method_type)
      expect{
        gaku_delete :destroy, id: @commute_method_type
      }.to change(Gaku::CommuteMethodType, :count).by -1

      controller.should set_the_flash
    end
  end

end