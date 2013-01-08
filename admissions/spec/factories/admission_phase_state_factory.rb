FactoryGirl.define do
  factory :admission_phase_state, :class => Gaku::AdmissionPhaseState do
    name 'State 1'
  end
  factory :admission_phase_state_pre_exam, :class => Gaku::AdmissionPhaseState do
    name 'Pre-Exam'
    can_progress  true
    can_admit     false
    auto_admit    false
  end
  factory :admission_phase_state_passed, :class => Gaku::AdmissionPhaseState do
    name 'Passed'
    can_progress  true
    auto_progress true
    can_admit     false
    auto_admit    false
  end
  factory :admission_phase_state_abscent, :class => Gaku::AdmissionPhaseState do
    name 'Abscent'
    can_progress  false
    can_admit     false
    auto_admit    false
  end
  factory :admission_phase_state_accepted, :class => Gaku::AdmissionPhaseState do
    name 'Accepted'
    can_progress  true
    can_admit     true
    auto_admit    true
  end
  factory :admission_phase_state_waiting, :class => Gaku::AdmissionPhaseState do
    name 'Waiting for interview'
    can_progress  true
    can_admit     false
    auto_admit    false
  end
  factory :admission_phase_state_rejected, :class => Gaku::AdmissionPhaseState do
    name 'Rejected'
    can_progress  false
    can_admit     false
    auto_admit    false
  end
  factory :admission_phase_state_passed_fluent, :class => Gaku::AdmissionPhaseState do
    name 'Passed with Fluent Score'
    can_progress  true
    can_admit     true
    auto_progress true
    auto_admit    true
  end
end