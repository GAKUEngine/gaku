require 'spec_helper'

describe Gaku::Admin::AdmissionsController do

  before do 
    @admission_period = create(:admission_period)
    @admission_method = create(:admission_method)
    @admission_period.admission_methods << @admission_method

  end
  
  describe "GET 'index'" do
    it "returns http success" do
      gaku_get :index
      response.should be_success
    end
  end

end