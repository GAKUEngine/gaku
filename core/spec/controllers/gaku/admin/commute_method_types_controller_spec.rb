require 'spec_helper'

describe Gaku::Admin::CommuteMethodTypesController do

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

end