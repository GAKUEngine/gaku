require 'spec_helper'

describe Gaku::GradingMethodsController do

  describe "GET index" do
    it "returns http success" do
      gaku_get :index
      response.should be_success
    end
  end

  describe "GET show" do
    pending "returns http success" do
      gaku_get :show
      response.should be_success
    end
  end

  describe "GET new" do
    it "returns http success" do
      gaku_get :new
      response.should be_success
    end
  end

  describe "GET edit" do
    pending "returns http success" do
      gaku_get :edit
      response.should be_success
    end
  end

end
