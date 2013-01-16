FactoryGirl.define do
  factory :admission, :class => Gaku::Admission do
    
    after_build do |admission|
      @method = FactoryGirl.build(:admission_method_regular)
      @admission_phase_record = FactoryGirl.create(:admission_phase_record, 
                                                    admission_id: admission.id, 
                                                    admission_phase_id: @method.admission_phases.first.id,
                                                    admission_phase_state_id: @method.admission_phases.first.admission_phase_states.first.id)
      admission.admission_method = @method
      admission.admission_period = FactoryGirl.build(:admission_period)
      admission.admission_phase_records = [@admission_phase_record]
      admission.admission_phase_record_id = @admission_phase_record.id
      admission.student = FactoryGirl.create(:student, admission: admission)
    end
    
  end
end