require 'spec_helper'

describe Gaku::Admin::AdmissionsController do

  before do 
    @admission_period = create(:admission_period)
    @admission_method = create(:admission_method)

  end
  
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

  describe 'GET #new' do

    it "renders the :new template" do
      gaku_js_get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    
  end

  xit 'changes admission period'

  xit 'changes admission method'

  xit 'changes student state'

  xit 'admits student'

  xit 'uses student chooser'

  xit 'create_multiple'

end