require 'spec_helper'

describe Gaku::Admin::CommuteMethodTypesController do

  let(:commute_method_type) { create(:commute_method_type) }

  describe 'GET #new' do
    it "assigns a new commute_method_type to @commute_method_type" do
      gaku_js_get :new, commute_method_type_id: commute_method_type.id
      assigns(:commute_method_type).should be_a_new(Gaku::CommuteMethodType)
    end

    it "renders the :new template" do
        gaku_js_get :new, commute_method_type_id: commute_method_type.id
        response.should render_template :new
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
    context "with invalid attributes" do
      it "does not save the new commute method type in the db" do
          expect{
            gaku_js_post :create, commute_method_type: {name: ''}  
          }.to_not change(Gaku::CommuteMethodType, :count)
      end
    end
  end

  describe 'GET #edit' do
    it "locates the requested commute_method_type" do
      gaku_js_get :edit, id: commute_method_type
      assigns(:commute_method_type).should eq(commute_method_type)
    end

    it "renders the :edit template" do
        gaku_js_get :edit, id: commute_method_type
        response.should render_template :edit
    end
  end

  describe "PUT #update" do
    it "locates the requested @commute_method_type" do
      gaku_put :update, id: commute_method_type, 
                        commute_method_type: attributes_for(:commute_method_type)
      assigns(:commute_method_type).should eq(commute_method_type)
    end

    context "valid attributes" do
      it "changes admission phase's attributes" do
        gaku_put :update, id: commute_method_type,
                          commute_method_type: attributes_for(:commute_method_type, name: "Train")
        commute_method_type.reload
        commute_method_type.name.should eq("Train")

        controller.should set_the_flash
      end
    end

    context "invalid attributes" do
      it "does not change admission phase's attributes" do
        gaku_js_put :update, id: commute_method_type, 
                              commute_method_type: attributes_for(:commute_method_type, name: "")

        commute_method_type.reload
        commute_method_type.name.should_not eq("")
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the admission method_phase" do
      commute_method_type
      expect{
        gaku_delete :destroy, id: commute_method_type
      }.to change(Gaku::CommuteMethodType, :count).by -1

      controller.should set_the_flash
    end
  end

end