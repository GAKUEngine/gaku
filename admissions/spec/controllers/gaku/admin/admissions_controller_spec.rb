require 'spec_helper'

describe Gaku::Admin::AdmissionsController do

  let!(:admission_period_no_methods) { create(:admission_period_no_methods) }
  let!(:admission_period) { create(:admission_period) }
  let!(:enrollment_status_applicant) { create(:enrollment_status_applicant, id:1) }
  let!(:enrollment_status_admitted) { create(:enrollment_status_admitted, id:2) }
  let!(:student) { create(:student, enrollment_status_id: 1) }
  let!(:exam) { create(:exam) }
  let!(:attendance) { create(:attendance) }
  let(:admission_method_regular) { create(:admission_method_regular) }
  #let(:admission) { create(:admission) }
  
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

    it "is successful" do
      response.should be_success
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

  end

  describe "POST #create" do
    context 'with valid attributes' do

      before do
        @admission = attributes_for(:admission, 
                                          admission_period_id: admission_period.id,
                                          admission_method_id: admission_method_regular.id,
                                          student_id: student.id)
      end
      it 'saves the new admission in the db' do
        expect do
          gaku_js_post :create, admission: @admission
        end.to change(Gaku::Admission, :count).by 1
      end
      it 'creates and saves new admission record in the db' do
        expect do
          gaku_js_post :create, admission: @admission
        end.to change(Gaku::AdmissionPhaseRecord, :count).by 1
      end

      xit 'changes student\'s enrollment status' do
        expect do
          gaku_js_post :create, admission: @admission
          student.reload
        end.to change(student,:enrollment_status_id)
      end
    end

    context 'with invalid attributes' do
      it 'raises error without student' do
        expect do
          gaku_post :create, admission: attributes_for(:admission, 
                                          admission_period_id: admission_period.id,
                                          admission_method_id: admission_method_regular.id,
                                          student_id: nil) 
        end.to raise_error
      end

      it 'raises error without method' do
        expect do
          gaku_post :create, admission: attributes_for(:admission, 
                                          admission_period_id: admission_period.id,
                                          admission_method_id: nil,
                                          student_id: student.id) 
        end.to raise_error
      end

      it 'raises error without period' do
        expect do
          gaku_post :create, admission: attributes_for(:admission, 
                                          admission_period_id: nil,
                                          admission_method_id: admission_method_regular.id,
                                          student_id: student.id) 
        end.to raise_error
      end


    end
    
  end

  context 'changes admission period' do

    it 'uses period with methods' do
      gaku_js_post :change_admission_period, admission_period: admission_period
      assigns(:admission_period).should eq admission_period
      assigns(:admission_methods).should eq admission_period.admission_methods
      assigns(:admission_method).should eq admission_period.admission_methods.first
      
      response.should be_success
    end

    it 'uses period without methods' do
      gaku_js_post :change_admission_period, admission_period: admission_period_no_methods
      assigns(:admission_period).should eq admission_period_no_methods
      assigns(:admission_methods).should eq admission_period_no_methods.admission_methods
      assigns(:admission_method).should eq nil
      
      response.should be_success
    end

  end

  it 'changes admission method' do
    gaku_js_post :change_admission_method, admission_method: admission_period.admission_methods.first
    assigns(:admission_method).should eq admission_period.admission_methods.first
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
      admission_period
      @current_state = admission_period.admission_methods.second.admission_phases.second.admission_phase_states.first #waiting for interview
      @new_state = admission_period.admission_methods.second.admission_phases.second.admission_phase_states.second #Accepted
      
      @admission_phase_record = create(:admission_phase_record, 
                                                    admission_phase_id: admission_period.admission_methods.second.admission_phases.second.id,
                                                    admission_phase_state_id: @current_state.id)

      @admission = create(:admission, 
                            admission_phase_record_id: @admission_phase_record.id, 
                            student_id: student.id)
      student.admission = @admission
      student.save!
      @admission_phase_record.admission = @admission
      @admission_phase_record.save!
    end 
    context 'when new state is auto progressable but not auto admittable' do
      it 'creates new admission record' do
        expect do
          gaku_js_post :change_student_state, 
                      state_id: @new_state.id, 
                      student_ids: [@admission.student_id], 
                      admission_period_id: admission_period.id,
                      admission_method_id: admission_period.admission_methods.second.id
        end.to change(Gaku::AdmissionPhaseRecord, :count).by 1
      end
    
    end
    context 'when new state is auto admittable' do
      it 'admits the student' do
        expect do
          gaku_js_post :change_student_state, 
                      state_id: @new_state.id, 
                      student_ids: [@admission.student_id], 
                      admission_period_id: admission_period.id,
                      admission_method_id: admission_period.admission_methods.second.id
        end.to change(@admission,:admitted).to true
      end
    end

    it "assigns variables" do
      gaku_js_post :change_student_state, 
                      state_id: @new_state.id, 
                      student_ids: [@admission.student_id], 
                      admission_period_id: admission_period.id,
                      admission_method_id: admission_period.admission_methods.second.id

      assigns(:state_students).should_not be_nil
      assigns(:state).should_not be_nil
      assigns(:admission_record).should_not be_nil
      assigns(:next_phase).should_not be_nil
      assigns(:new_state).should_not be_nil
      assigns(:new_admission_record).should_not be_nil
    end

    it 'is successful' do
      gaku_js_post :change_student_state, 
                      state_id: @new_state.id, 
                      student_ids: [@admission.student_id], 
                      admission_period_id: admission_period.id,
                      admission_method_id: admission_period.admission_methods.second.id
      response.should be_success
    end

    it "renders the :change_student_state view" do
      gaku_js_post :change_student_state, 
                      state_id: @new_state.id, 
                      student_ids: [@admission.student_id], 
                      admission_period_id: admission_period.id,
                      admission_method_id: admission_period.admission_methods.second.id
      response.should render_template :change_student_state
    end
      
  end

  xit 'admits student'

  xit 'uses student chooser'

  xit 'create_multiple'

end