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