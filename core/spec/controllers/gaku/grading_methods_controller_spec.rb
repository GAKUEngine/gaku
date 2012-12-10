require 'spec_helper'

describe Gaku::GradingMethodsController do

  describe "GET index" do
    it "returns http success" do
      gaku_get :index
      response.should be_success
    end
  end

  describe "GET new" do
    it "returns http success" do
      gaku_js_get :new
      response.should be_success
    end
  end

end
