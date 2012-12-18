require 'spec_helper'

describe Gaku::ClassGroupsController do

  let(:class_group) { create(:class_group) }

  describe "GET #index" do
    it "is successful" do
      gaku_js_get :index
      response.should be_success
    end

    it "populates an array of class_groups" do
      gaku_js_get :index
      assigns(:class_groups).should eq [class_group]
    end

    it "renders the :index view" do
      gaku_js_get :index
      response.should render_template :index
    end
  end 

  describe 'GET #show' do
    
    it "is successful" do
      gaku_js_get :show, id: class_group
      response.should be_success
    end

    it "assigns the requested class_group to @class_group" do
      gaku_js_get :show, id: class_group
      assigns(:class_group).should eq class_group
    end

    it "renders the :show template" do
      gaku_js_get :show, id: class_group
      response.should render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new class_group to @class_group" do
      gaku_js_get :new
      assigns(:class_group).should be_a_new(Gaku::ClassGroup)
    end

    it "renders the :new template" do
      gaku_js_get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new class group in the db" do
        expect{
          gaku_js_post :create, class_group: attributes_for(:class_group)  
        }.to change(Gaku::ClassGroup, :count).by 1
        
      end
    end
    context "with invalid attributes" do
      it "does not save the new class group in the db" do
        expect{
          gaku_js_post :create, class_group: {name: ''}  
        }.to_not change(Gaku::ClassGroup, :count)
      end
    end
  end

  describe 'GET #edit' do
    it "locates the requested class_group" do
      gaku_js_get :edit, id: class_group
      assigns(:class_group).should eq(class_group)
    end

    it "renders the :edit template" do
        gaku_js_get :edit, id: class_group
        response.should render_template :edit
    end
  end

  describe "PUT #update" do
    it "locates the requested @class_group" do
      gaku_js_put :update, id: class_group, class_group: attributes_for(:class_group) 
      assigns(:class_group).should eq(class_group)
    end

    context "valid attributes" do
      it "changes class group's attributes" do
        gaku_js_put :update, id: class_group,class_group: attributes_for(:class_group, name: "AZ")
        class_group.reload
        class_group.name.should eq("AZ")
      end
    end
    context "invalid attributes" do
      it "does not change class group's attributes" do
        gaku_js_put :update, id: class_group, 
                              class_group: attributes_for(:class_group, name: "")
        class_group.reload
        class_group.name.should_not eq("")
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the class group" do
      @class_group = create(:class_group)
      expect{
        gaku_delete :destroy, id: @class_group
      }.to change(Gaku::ClassGroup, :count).by -1

      controller.should set_the_flash
    end
  end
end