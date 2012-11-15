admission_periods = ["P1", "P2", "P3"]
admission_methods = ["M1", "M2", "M3"]
admission_method_phases = ["P1","P2","P3"]
admission_method_phase_states = ["S1","S2","S3"]


admission_periods.each do |period_name|
  period = Gaku::AdmissionPeriod.create(:name => period_name)
  admission_methods.each do |method_name|
    method = Gaku::AdmissionMethod.create(:name => period_name + "-" + method_name)
    admission_method_phases.each do |phase_name|
      phase = Gaku::AdmissionPhase.create(:name => period_name + "-" + method_name + "-" + phase_name)
      admission_method_phase_states.each do |state_name|
        state = Gaku::AdmissionPhaseState.create(:name => period_name + "-" + method_name + "-" + phase_name + "-" + state_name)
        phase.admission_phase_states << state
      end
      method.admission_phases << phase
    end
    period.admission_methods << method
  end
end

#{}"admission_method_id", "admitted", "created_at", 
#{}"scholarship_status_id", "student_id", "updated_at"
#      t.references :admission
#      t.references :admission_phase
#      t.references :admission_phase_state
admission = Gaku::Admission.create( 
            :student_id => 1, 
            :admission_method_id => Gaku::AdmissionMethod.first.id)
admission_record = Gaku::AdmissionPhaseRecord.create(
            :admission_id => admission.id,
            :admission_phase_id => Gaku::AdmissionPhase.first.id,
            :admission_phase_state_id => Gaku::AdmissionPhase.first.admission_phase_states.first.id)
admission2 = Gaku::Admission.create( 
            :student_id => 2, 
            :admission_method_id => Gaku::AdmissionMethod.first.id)
admission_record2 = Gaku::AdmissionPhaseRecord.create(
            :admission_id => admission2.id,
            :admission_phase_id => Gaku::AdmissionPhase.first.id,
            :admission_phase_state_id => Gaku::AdmissionPhase.first.admission_phase_states.first.id)

admission3 = Gaku::Admission.create( 
            :student_id => 3, 
            :admission_method_id => Gaku::AdmissionPhase.first.id)
admission_record3 = Gaku::AdmissionPhaseRecord.create(
            :admission_id => admission3.id,
            :admission_phase_id => Gaku::AdmissionPhase.first.id,
            :admission_phase_state_id => 2)
admission4 = Gaku::Admission.create( 
            :student_id => 4, 
            :admission_method_id => Gaku::AdmissionMethod.first.id)
admission_record4 = Gaku::AdmissionPhaseRecord.create(
            :admission_id => admission4.id,
            :admission_phase_id => Gaku::AdmissionPhase.first.id,
            :admission_phase_state_id => 2)