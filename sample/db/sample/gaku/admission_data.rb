# -*- encoding: utf-8 -*-

#  { name: "Early Admissions"},
#  { name: "International Division Admissions"},
#  { name: "一般入学"},
#  { name: "推薦入学"},
#  { name: "国際コース入学"}
#]
#
#admission_methods.each do |method_data|
#  method = Gaku::AdmissionMethod.create(method_data)
#  method.phases.each do |phase_data|
#    phase = Gaku::AdmissionPhase.create(phase_data)
#   # admission_method_phase_states.each do |state_name|
#   #   state = Gaku::AdmissionPhaseState.create(name: period_name + "-" + method_name + "-" + phase_name + "-" + state_name)
#   #   phase.admission_phase_states << state
#   # end
#    method.admission_phases << phase
#    method.save
#  end
#end
def add_exam_to_phase(phase_info, phase)
  exam = Gaku::Exam.where(phase_info[:exam]).first_or_create!
    phase.exam = exam
    phase.save
    phase_info[:exam_portions].each do |portion|
      exam_portion = Gaku::ExamPortion.where(portion).build
      exam_portion.exam_id = phase.exam.id
      exam_portion.save
      phase.exam.exam_portions << exam_portion
    end
end

def add_states_to_phase(phase_states, phase)
  phase_states.each do |state_data|
    phase_state = Gaku::AdmissionPhaseState.new(state_data)
    if phase_state.is_default == true
      default_state = phase.admission_phase_states.find_by_is_default(true)
      default_state.update_attributes(state_data)
    else
      phase_state.save
      phase.admission_phase_states << phase_state
    end
  end
  phase.save
end

def create_sample_admission_method(method_args, phase_array)
  method = Gaku::AdmissionMethod.where(method_args).first_or_create!
  phase_array.each do |phase_info|
    phase = method.admission_phases.build(phase_info[:args])
    add_exam_to_phase(phase_info, phase) if phase_info[:exam]
    add_states_to_phase(phase_info[:states], phase) if phase.save
  end
  method.save
  return method
end

regular_method = create_sample_admission_method(
  { name: "Regular Admissions" },
  [
    {
      args: { name: "Written Application", position: 0 },
      states: [
        { name: "Received", :can_progress => true, :is_default => true },
        { name: "In Review" },
        { name: "Accepted", auto_progress: true, can_progress: true },
        { name: "Rejected", can_progress: false }
      ]
    },{
      args: { name: "Written Report", position: 1 },
      states: [
        { name: "In Review", :can_progress => true, :is_default => true },
        { name: "Accepted", auto_progress: true, can_progress: true, can_admit: true },
        { name: "Rejected", can_progress: false }
      ]
    },{
      args: { name: "Exam", position: 2 },
      exam: { name: "Summer Program Entry", use_weighting: true, weight: 100},
      exam_portions: [{name: "exam", max_score: 100, weight: 100, problem_count: 1}],
      states: [
        { name: "Pre-Exam", :can_progress => true, :is_default => true  },
        { name: "Passed", can_admit: true, can_progress: true, auto_progress: true },
        { name: "Rejected", can_admit: false, can_progress: false },
        { name: "Abscent", can_admit: false, can_progress: false }
      ]
    },{
      args: { name: "Interview", position: 3 },
      states: [
        { name: "Waiting for Interview", :can_progress => true, :is_default => true },
        { name: "Accepted", can_admit: true, :auto_admit => true },
        { name: "Rejected", can_admit: false }
      ]
    }
  ]
)

international_division_method = create_sample_admission_method(
  { name: "International Division Admissions" },
  [
    {
      args: { name: "Written Application", position: 0 },
      states: [
        { name: "Received", :can_progress => true, :is_default => true },
        { name: "In Review" },
        { name: "Accepted", auto_progress: true, can_progress: true },
        { name: "Rejected", can_progress: false }
      ]
    },

    {
      args: { name: "Interview", position: 1 },
      states: [
        { name: "Waiting for Interview", :can_progress => true, :is_default => true },
        { name: "Accepted", can_admit: true, :auto_admit => true },
        { name: "Rejected", can_admit: false }
      ]
    },

    {
      args: { name: "Exam", position: 2 },
      states: [
        { name: "Pre-Exam", :can_progress => true, :is_default => true },
        { name: "Passed", can_admit: true, can_progress: true, auto_progress: true },
        { name: "Rejected", can_admit: false, can_progress: false },
        { name: "Abscent", can_admit: false, can_progress: false }
      ]
    },

    {
      args: { name: "Foreign Langauge Exam", position: 3 },
      states: [
        { name: "Pre-Exam", :can_progress => true, :is_default => true },
        { name: "Passed with Fluent Score", can_admit: true, can_progress: true, auto_progress: true, :auto_admit => true },
        { name: "Passed", can_admit: true, can_progress: true, auto_progress: true },
        { name: "Rejected", can_admit: false, can_progress: false },
        { name: "Abscent", can_admit: false, can_progress: false }
      ]
    },

    {
      args: { name: "Written Report", position: 4 },
      states: [
        { name: "In Review", :can_progress => true, :is_default => true },
        { name: "Accepted", auto_progress: true, can_progress: true, can_admit: true },
        { name: "Rejected", can_progress: false }
      ]
    }
  ]
)

summer_method = create_sample_admission_method(
  { name: "Summer Program Admissions"},
  [
    {
      args: { name: "Written Application", position: 0 },
      states: [
        { name: "Received", :can_progress => true, :is_default => true },
        { name: "In Review" },
        { name: "Accepted", auto_progress: true, can_progress: true },
        { name: "Rejected", can_progress: false }
      ]
    },

    {
      args: { name: "Written Report", position: 1 },
      states: [
        { name: "In Review", :can_progress => true, :is_default => true },
        { name: "Accepted", auto_progress: true, can_progress: true, can_admit: true },
        { name: "Rejected", can_progress: false }
      ]
    },

    {
      args: { name: "Interview", position: 2 },
      states: [
        { name: "Waiting for Interview", :can_progress => true, :is_default => true },
        { name: "Accepted", can_admit: true, :auto_admit => true },
        { name: "Rejected", can_admit: false }
      ]
    }
  ]
)

# Periods
period1 = Gaku::AdmissionPeriod.where(name: "Summer 2013").first_or_create!
period1.admission_methods << summer_method

Gaku::AdmissionPeriod.where(name: "Fall 2013 Early Admissions").first_or_create!

period2 = Gaku::AdmissionPeriod.where(name: "Fall 2013").first_or_create!
period2.admission_methods << regular_method
period2.admission_methods << international_division_method

Gaku::AdmissionPeriod.where(name: "2013年夏短期プログラム").first_or_create!
Gaku::AdmissionPeriod.where(name: "2013年秋推薦").first_or_create!
Gaku::AdmissionPeriod.where(name: "2013年秋").first_or_create!

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
