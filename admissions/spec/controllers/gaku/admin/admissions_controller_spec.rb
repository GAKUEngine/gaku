require 'spec_helper'

describe Gaku::Admin::AdmissionsController do

  let!(:admission_period_no_methods) { create(:admission_period_no_methods) }
  let!(:admission_period) { create(:admission_period) }
  let!(:student) { create(:student) }
  let!(:exam) { create(:exam) }
  let!(:attendance) { create(:attendance) }
  let(:admission_method_regular) { create(:admission_method_regular) }
  
  
  describe "GET #index" do
    before do
      gaku_get :index
    end

    it "is successful" do
      response.should be_success
    end

    it "renders the :index view" do
      response.should render_template :index
    end

    it "loads @admission_periods" do
      assigns(:admission_periods).should_not be_nil
    end
    it "loads @admission_period" do
      assigns(:admission_period).should_not be_nil
    end

    it "loads @admission_methods" do
      assigns(:admission_methods).should_not be_nil
    end

    it "loads @admission_method" do
      assigns(:admission_method).should_not be_nil
    end

    it "loads @search" do
      assigns(:search).should_not be_nil
    end
    it "loads @students" do
      assigns(:students).should_not be_nil
    end
    it "loads @class_groups" do
      assigns(:class_groups).should_not be_nil
    end
    it "loads @courses" do
      assigns(:courses).should_not be_nil
    end

    it "loads @state_records" do
      assigns(:state_records).should_not be_nil
    end

  end

  describe 'GET #new' do
    before do
      gaku_js_get :new
    end
    it "renders the :new template" do
      response.should render_template :new
    end

    it "loads @class_groups" do
      assigns(:class_groups).should_not be_nil
    end

    xit "loads @class_group_id" do
      assigns(:class_group_id).should_not be_nil
    end

    it "loads @scholarship_statuses" do
      assigns(:scholarship_statuses).should_not be_nil
    end

    it "assigns a new admission" do
      assigns(:admission).should be_a_new Gaku::Admission
    end

    it "assigns a new student" do
      assigns(:student).should be_a_new Gaku::Student
    end
  end

  describe "POST #create" do
    context 'with valid attributes' do

      xit 'saves the new admission in the db' do
        expect do
          gaku_post :create, admission: attributes_for(:admission, 
                                                        admission_period_id:admission_period, 
                                                        admission_method_id:admission_method_regular)
        end.to change(Gaku::Admission, :count).by 1
      end
    end

    context 'with invalid attributes' do
      xit 'does not save the new admission in the db' do
        expect do
          gaku_post :create, admission: attributes_for(:admission, 
                                                        admission_period_id:admission_period, 
                                                        admission_method_id:admission_method_regular, 
                                                        student_id: nil )
        end.to_not change(Gaku::Admission, :count)
      end
    end
    
  end

  context 'changes admission period' do

    it 'uses period with methods' do
      gaku_js_post :change_admission_period, admission_period: admission_period
      assigns(:admission_period).should eq admission_period
      assigns(:admission_methods).should eq admission_period.admission_methods
      assigns(:admission_method).should eq admission_period.admission_methods.first
      session[:admission_period_id].should eq admission_period.id
      session[:admission_method_id].should eq admission_period.admission_methods.first.id
      response.should be_success
    end
    it 'uses period without methods' do
      gaku_js_post :change_admission_period, admission_period: admission_period_no_methods
      assigns(:admission_period).should eq admission_period_no_methods
      assigns(:admission_methods).should eq admission_period_no_methods.admission_methods
      assigns(:admission_method).should eq nil
      session[:admission_period_id].should eq admission_period_no_methods.id
      session[:admission_method_id].should eq nil
      response.should be_success
    end
    xit 'without periods'
  end
  xit 'changes admission method'

  xit 'changes student state'

  xit 'admits student'

  xit 'uses student chooser'

  xit 'create_multiple'

end