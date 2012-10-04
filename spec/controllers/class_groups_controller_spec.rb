require 'spec_helper'

describe ClassGroupsController do

  let(:class_group) { create(:class_group) }

  before do
    login_admin
  end

  describe "GET :index	" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end 

  describe "POST create" do
    it "redirects to the new class group" do
      page.stub :save => true

      post :create
      response.should redirect_to(class_group_url(ClassGroup.last))
    end
  end

  describe "PUT update" do

    it "redirects to the class group" do
      page.stub :update_attributes => true

      post :update, :id => class_group.id
      response.should redirect_to(class_group_url(class_group))
    end
  end

  describe "destroying a class group" do

    it "doesn't set the flash on xhr requests'" do
      xhr :delete, :destroy, :id => class_group
      controller.should_not set_the_flash
    end

    it "sets the flash" do
      delete :destroy, :id => class_group
      controller.should set_the_flash
    end
  end
end