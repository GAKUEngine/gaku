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

    it "assigns variables" do
      assigns(:admission_periods).should_not be_nil
      assigns(:admission_period).should_not be_nil
      assigns(:admission_methods).should_not be_nil
      assigns(:admission_method).should_not be_nil
      assigns(:search).should_not be_nil
      assigns(:students).should_not be_nil
      assigns(:class_groups).should_not be_nil
      assigns(:courses).should_not be_nil
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
    it "assigns variables" do
      assigns(:class_groups).should_not be_nil
      assigns(:scholarship_statuses).should_not be_nil
      assigns(:admission).should be_a_new Gaku::Admission
      assigns(:student).should be_a_new Gaku::Student
    end

    xit "loads @class_group_id" do
      assigns(:class_group_id).should_not be_nil
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
  it 'changes admission method' do
    gaku_js_post :change_admission_method, admission_method: admission_period.admission_methods.first
    assigns(:admission_method).should eq admission_period.admission_methods.first
    session[:admission_method_id].should eq admission_period.admission_methods.first.id
  end

  context 'lists admissions' do
    before do
      gaku_js_get :listing_admissions
    end
    it 'is successful' do
      response.should be_success
    end
    it "renders the :listing_admissions view" do
      response.should render_template :listing_admissions
    end

    it "assigns variables" do
      assigns(:admission_periods).should_not be_nil
      assigns(:admission_period).should_not be_nil
      assigns(:admission_methods).should_not be_nil
      assigns(:admission_method).should_not be_nil
      assigns(:search).should_not be_nil
      assigns(:students).should_not be_nil
      assigns(:class_groups).should_not be_nil
      assigns(:courses).should_not be_nil
      assigns(:state_records).should_not be_nil
    end
    
  end
  context 'changes student state' do
    before do
      gaku_js_post :change_student_state, state_id: 1
    end
    context 'when new state is auto progressable' do
      it 'creates new admission record' do
      end
    end
    context 'when new state is auto admittable' do
      it 'admits the student' do
      end
    end
    it "assigns variables" do
      assigns(:state_id).should_not be_nil
      assigns(:student).should_not be_nil
      assigns(:admission_record).should_not be_nil
    end
    it 'changes admission record' do
      expect do
      end.to change(:admission_record.admission_phase_state_id)
    end
    it 'is successful' do
      response.should be_success
    end

    it "renders the :change_student_state view" do
      response.should render_template :change_student_state
    end
      
  end

  xit 'admits student'

  xit 'uses student chooser'

  xit 'create_multiple'

end