FactoryGirl.define do
  factory :admission_phase_state, :class => Gaku::AdmissionPhaseState do
    name 'State 1'
    can_progress  true
    can_admit     false
    auto_admit    false
  end
end