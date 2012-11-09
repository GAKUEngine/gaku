require 'spec_helper'

describe Gaku::Admin::AdmissionsController do

  describe "GET 'index'" do
    it "returns http success" do
      gaku_get :index
      response.should be_success
    end
  end

end
