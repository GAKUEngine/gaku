# -*- encoding: utf-8 -*-

#admission_methods = [
#  { :name => "Summer Program",
#    admission_phases = [
#      { :name => "Written Application",
#        admission_phase_states = [
#          { :name => "Received" },
#          { :name => "In Review" },
#          { :name => "Accepted", :auto_progress => true, :can_progress => true },
#          { :name => "Rejected", :can_progress => false }
#        ]
#      },
#      { :name => "Written Report",
#        admission_phase_states = [
#          { :name => "In Review" },
#          { :name => "Accepted", :auto_progress => true, :can_progress => true, :can_admit => true },
#          { :name => "Rejected", :can_progress => false }
#        ]
#      },
#      { :name => "Interview",
#        states = [
#          { :name => "Waiting for Interview" },
#          { :name => "Accepted", :can_admit => true, :auto_admit => true },
#          { :name => "Rejected", :can_admit => false }
#        ]
#      }
#    ]
#  },
#  { :name => "Early Admissions"},
#  { :name => "International Division Admissions"},
#  { :name => "Regular Admissions"},
#  { :name => "一般入学"},
#  { :name => "推薦入学"},
#  { :name => "国際コース入学"}
#]
#
#admission_methods.each do |method_data|
#  method = Gaku::AdmissionMethod.create(method_data)
#  method.phases.each do |phase_data|
#    phase = Gaku::AdmissionPhase.create(phase_data)
#   # admission_method_phase_states.each do |state_name|
#   #   state = Gaku::AdmissionPhaseState.create(:name => period_name + "-" + method_name + "-" + phase_name + "-" + state_name)
#   #   phase.admission_phase_states << state
#   # end
#    method.admission_phases << phase
#    method.save
#  end
#end

### Summer Program Sample Admission Method
method = Gaku::AdmissionMethod.create({ :name => "Summer Program Admissions"})

phase = Gaku::AdmissionPhase.create({ :name => "Written Application"})

phase_states = [
  { :name => "Received" },
  { :name => "In Review" },
  { :name => "Accepted", #:auto_progress => true, 
    :can_progress => true },
  { :name => "Rejected", :can_progress => false }
]

phase_states.each do |state_data|
  phase_state = Gaku::AdmissionPhaseState.create(state_data)
  phase.admission_phase_states << phase_state
end
phase.save

method.admission_phases << phase
method.save


admission_periods = [
  { :name => "Summer 2013"},
  { :name => "Fall 2013 Early Admissions"},
  { :name => "Fall 2013"},
  { :name => "2013年夏短期プログラム"},
  { :name => "2013年秋推薦"},
  { :name => "2013年秋"}
]

admission_periods.each do |period_data|
  Gaku::AdmissionPeriod.create(period_data)
end

#{}"admission_method_id", "admitted", "created_at", 
#{}"scholarship_status_id", "student_id", "updated_at"
#      t.references :admission
#      t.references :admission_phase
#      t.references :admission_phase_state

#admission = Gaku::Admission.create( 
#            :student_id => 1, 
#            :admission_method_id => Gaku::AdmissionMethod.first.id)
#admission_record = Gaku::AdmissionPhaseRecord.create(
#            :admission_id => admission.id,
#            :admission_phase_id => Gaku::AdmissionPhase.first.id,
#            :admission_phase_state_id => Gaku::AdmissionPhase.first.admission_phase_states.first.id)
#admission2 = Gaku::Admission.create( 
#            :student_id => 2, 
#            :admission_method_id => Gaku::AdmissionMethod.first.id)
#admission_record2 = Gaku::AdmissionPhaseRecord.create(
#            :admission_id => admission2.id,
#            :admission_phase_id => Gaku::AdmissionPhase.first.id,
#            :admission_phase_state_id => Gaku::AdmissionPhase.first.admission_phase_states.first.id)
#
#admission3 = Gaku::Admission.create( 
#            :student_id => 3, 
#            :admission_method_id => Gaku::AdmissionPhase.first.id)
#admission_record3 = Gaku::AdmissionPhaseRecord.create(
#            :admission_id => admission3.id,
#            :admission_phase_id => Gaku::AdmissionPhase.first.id,
#            :admission_phase_state_id => 2)
#admission4 = Gaku::Admission.create( 
#            :student_id => 4, 
#            :admission_method_id => Gaku::AdmissionMethod.first.id)
#admission_record4 = Gaku::AdmissionPhaseRecord.create(
#            :admission_id => admission4.id,
#            :admission_phase_id => Gaku::AdmissionPhase.first.id,
#            :admission_phase_state_id => 2)
