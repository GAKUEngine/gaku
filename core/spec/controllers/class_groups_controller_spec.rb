require 'spec_helper'

describe Gaku::ClassGroupsController do

  let(:class_group) { create(:class_group) }

  before do
    login_admin
  end

  describe "GET index" do
    it "should be successful" do
      gaku_get :index
      response.should be_success
    end
  end 

  describe "POST create" do
    it "redirects to the new class group" do
      page.stub :save => true

      gaku_post :create, class_group: attributes_for(:class_group)
      response.should redirect_to(class_group_url(ClassGroup.last))
    end
  end

  describe "PUT update" do

    it "redirects to the class group" do
      page.stub :update_attributes => true

      gaku_post :update, :id => class_group.id
      response.should redirect_to(class_group_url(class_group))
    end
  end

  describe "destroying a class group" do
    it "sets the flash" do
      gaku_delete :destroy, :id => class_group
      controller.should set_the_flash
    end
  end
end