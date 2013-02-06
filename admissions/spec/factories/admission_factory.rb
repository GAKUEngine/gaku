FactoryGirl.define do
  factory :admission, :class => Gaku::Admission do
    
    after_create do |admission|
      @admission_phase_record = FactoryGirl.create(:admission_phase_record, 
                                                    admission_id: admission.id, 
                                                    admission_phase_id: admission.admission_period.admission_methods.first.admission_phases.first.id,
                                                    admission_phase_state_id: admission.admission_period.admission_methods.first.admission_phases.first.admission_phase_states.first.id)
      
      admission.admission_method_id = admission.admission_period.admission_methods.first.id
      #admission.admission_method.admission_period_id = admission.admission_period.id
      admission.admission_phase_records = [@admission_phase_record]
      admission.admission_phase_record_id = @admission_phase_record.id
      admission.save!
    end
    
  end
end