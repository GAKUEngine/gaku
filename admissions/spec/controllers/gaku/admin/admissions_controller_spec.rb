require 'spec_helper'

describe Gaku::Admin::AdmissionsController do

  let!(:admission_period_no_methods) { create(:admission_period_no_methods) }
  let!(:admission_period) { create(:admission_period) }
  let!(:enrollment_status_applicant) { create(:enrollment_status_applicant, id:1) }
  let!(:enrollment_status_admitted) { create(:enrollment_status_admitted, id:2) }
  let!(:student) { create(:student, enrollment_status_id: 1) }
  let!(:exam) { create(:exam) }
  let!(:attendance) { create(:attendance) }
  let(:admission_method) { create(:admission_method_with_phases) }
  
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
                                          admission_method_id: admission_method.id,
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
                                          admission_method_id: admission_method.id,
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
                                          admission_method_id: admission_method.id,
                                          student_id: student.id) 
        end.to raise_error
      end


    end
    
  end

  context 'changes admission period' do

    it 'uses period with methods' do
      gaku_js_get :change_admission_period, admission_period: admission_period
      assigns(:admission_period).should eq admission_period
      assigns(:admission_methods).should eq admission_period.admission_methods
      assigns(:admission_method).should eq admission_period.admission_methods.first
      
      response.should be_success
    end

    xit 'uses period without methods' do
      gaku_js_get :change_admission_period, admission_period: admission_period_no_methods
      assigns(:admission_period).should eq admission_period_no_methods
      assigns(:admission_methods).should eq admission_period_no_methods.admission_methods
      assigns(:admission_method).should eq nil
      
      response.should be_success
    end

  end

  it 'changes admission method' do
    gaku_js_get :change_admission_method, admission_method: admission_period.admission_methods.first
    assigns(:admission_method).should eq admission_period.admission_methods.first
  end

  it 'changes period method' do
    gaku_js_get :change_period_method, admission_method: admission_period.admission_methods.first
    
    assigns(:admission_periods).should eq [admission_period_no_methods, admission_period]
    assigns(:admission_period).should eq admission_period
    assigns(:admission_method).should eq admission_period.admission_methods.first
    assigns(:admission_methods).should eq admission_period.admission_methods

    response.should be_success

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

  context 'lists applicants' do
    before do
      gaku_js_get :listing_applicants
    end

    it 'is successful' do
      response.should be_success
    end

    it "renders the :listing_applicants view" do
      response.should render_template :listing_applicants
    end

    it "assigns variables" do
      assigns(:admission_periods).should_not be_nil
      assigns(:admission_period).should_not be_nil
      assigns(:admission_methods).should_not be_nil
      assigns(:admission_method).should_not be_nil
      assigns(:search).should_not be_nil
      assigns(:students).should_not be_nil
      assigns(:admission_params).should_not be_nil
    end  
  end

  context 'changes student state' do
     
    context 'when new state is auto progressable but not auto admittable' do
      before do
        @current_state = admission_period.admission_methods.second.admission_phases.first.admission_phase_states.first #pre exam
        @admission_phase_record = create(:admission_phase_record, 
                                                      admission_phase_id: admission_period.admission_methods.second.admission_phases.first.id,
                                                      admission_phase_state_id: @current_state.id)
        @new_state = admission_period.admission_methods.second.admission_phases.first.admission_phase_states.third #passed

        @admission = create(:admission, 
                              student_id: student.id)

        student.admission = @admission
        student.save!

        @admission_phase_record.admission = @admission
        @admission_phase_record.save!
      end

      it 'creates new admission phase record'  do
        expect do
          gaku_js_post :change_student_state, 
                        state_id: @new_state.id, 
                        student_ids: [@admission.student_id], 
                        admission_period_id: admission_period.id,
                        admission_method_id: admission_period.admission_methods.second.id
        end.to change(Gaku::AdmissionPhaseRecord, :count).by 1
      end

      context 'when make post request, it' do
        before do
          gaku_js_post :change_student_state, 
                        state_id: @new_state.id, 
                        student_ids: [@admission.student_id], 
                        admission_period_id: admission_period.id,
                        admission_method_id: admission_period.admission_methods.second.id
        end
        it "assigns variables" do
          assigns(:state_students).should_not be_nil
          assigns(:next_state).should_not be_nil
          assigns(:admission_record).should_not be_nil
          assigns(:new_state).should_not be_nil
        end
        it 'is successful' do
          response.should be_success
        end

        it "renders the :change_student_state view" do
          response.should render_template :change_student_state
        end
      end
      
    
    end
    context 'when new state is auto admittable but not auto pregressable' do
      before do
        @current_state = admission_period.admission_methods.second.admission_phases.second.admission_phase_states.second #waiting for interview
        @new_state = admission_period.admission_methods.second.admission_phases.second.admission_phase_states.third #Accepted
        
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

        gaku_js_post :change_student_state, 
                      state_id: @new_state.id, 
                      student_ids: [@admission.student_id], 
                      admission_period_id: admission_period.id,
                      admission_method_id: admission_period.admission_methods.second.id
      end

      it 'admits the student' do
        expect do
          gaku_js_post :change_student_state, 
                      state_id: @new_state.id, 
                      student_ids: [@admission.student_id], 
                      admission_period_id: admission_period.id,
                      admission_method_id: admission_period.admission_methods.second.id
          @admission.reload
        end.to change(@admission,:admitted).to true
      end
    
      it "assigns variables" do
        assigns(:state_students).should_not be_nil
        assigns(:next_state).should_not be_nil
        assigns(:admission_record).should_not be_nil
        assigns(:next_phase).should be_nil
        assigns(:new_state).should be_nil
        assigns(:new_admission_record).should be_nil
      end

      it 'is successful' do
        response.should be_success
      end

      it "renders the :change_student_state view" do
        response.should render_template :change_student_state
      end
    end
      
  end

  it 'uses student chooser' do
    gaku_js_get :student_chooser

    assigns(:admission_periods).should_not be_nil
    assigns(:admission_period).should_not be_nil
    assigns(:admission_methods).should_not be_nil
    assigns(:admission_method).should_not be_nil
    assigns(:search).should_not be_nil
    assigns(:selected_students).should_not be_nil
    assigns(:admissions).should_not be_nil
    assigns(:admission).should_not be_nil
    assigns(:enrolled_students).should eq []
    assigns(:method_admissions).should_not be_nil
    assigns(:applicant_max_number).should_not be_nil

    response.should be_success
  end

  context 'create multiple' do
    it 'assigns variables' do
      
      gaku_js_post :create_multiple, admission_period_id: admission_period.id,
                                     admission_method_id: admission_period.admission_methods.first.id,
                                     selected_students: ["student-#{student.id}"]

      assigns(:admission_periods).should_not be_nil
      assigns(:admission_period).should_not be_nil
      assigns(:admission_methods).should_not be_nil
      assigns(:admission_method).should_not be_nil
      assigns(:selected_students).should eq ["student-#{student.id}"]
      assigns(:admission_records).should_not be_nil

      response.should be_success
    end

    it 'creates an admission' do
      expect do
        gaku_js_post :create_multiple, admission_period_id: admission_period.id,
                                     admission_method_id: admission_period.admission_methods.first.id,
                                     selected_students: ["student-#{student.id}"]
      end.to change(Gaku::Admission, :count).by 1
    end

    it 'creates an admission record' do
      expect do
        gaku_js_post :create_multiple, admission_period_id: admission_period.id,
                                     admission_method_id: admission_period.admission_methods.first.id,
                                     selected_students: ["student-#{student.id}"]
      end.to change(Gaku::AdmissionPhaseRecord, :count).by 1
    end

    pending 'makes student aplicant (check if test is unneeded)' do
      @student = create(:student)
      expect do
        gaku_js_post :create_multiple, admission_period_id: admission_period.id,
                                     admission_method_id: admission_period.admission_methods.first.id,
                                     selected_students: ["student-#{@student.id}"]
        @student.reload
        raise @student.enrollment_status
      end.to change(@student,:enrollment_status_id)
    end
  end

  context 'soft_delete' do
    
    before do
      @admission = attributes_for(:admission, 
                                          admission_period_id: admission_period.id,
                                          admission_method_id: admission_method.id,
                                          student_id: student.id)
      gaku_js_post :create, admission: @admission
      expect(response).to be_success
      @admission = Gaku::Admission.all.first
      gaku_js_post :soft_delete, id:@admission.id
      @admission.reload
    end

    it 'changes is deleted attribute' do
      expect(@admission.is_deleted).to eq true
    end

    it 'changes is deleted attribute for all admission\'s phase records' do
      @admission.admission_phase_records.each do |rec|
          expect(rec.is_deleted).to eq true
      end
    end
  end

end