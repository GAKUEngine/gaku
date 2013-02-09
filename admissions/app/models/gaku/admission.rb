module Gaku
  class Admission < ActiveRecord::Base

    include Notes, Trashable

    belongs_to :student
    belongs_to :scholarship_status
    belongs_to :admission_method
    belongs_to :admission_period

    has_many :specialty_applications
    has_many :admission_phase_records
    has_many :exam_scores, :through => :admission_phase_records
    has_many :attachments, as: :attachable

    has_one :external_school_record

    accepts_nested_attributes_for :admission_phase_records, :allow_destroy => true
    accepts_nested_attributes_for :student

    attr_accessible :student_id, :applicant_number, :scholarship_status_id,
                    :admission_method_id, :admission_period_id,
                    :student_attributes, :admitted

    #validates :applicant_number, :presence => true, :uniqueness => {:scope => :admission_method_id}

    def student
      Student.unscoped{ super }
    end

    def change_student_to_applicant
      student.make_applicant
    end

    def change_applicant_to_student(admission_date)
      student.make_admitted(admission_date)
    end

    def admit(student)
      admission_date = !student.admission.admission_period.admitted_on.nil? ? student.admission.admission_period.admitted_on : Date.today
      admission = student.admission
      admission.admitted = true
      admission.save
      student.make_admitted(admission_date)
    end

    def progress_to_next_phase(phase)
      next_phase = AdmissionPhase.find_next_phase(phase)
      new_state = next_phase.admission_phase_states.first
      
      new_admission_record = AdmissionPhaseRecord.new
      new_admission_record.admission = student.admission
      new_admission_record.admission_phase = next_phase
      new_admission_record.admission_phase_state = new_state
      new_admission_record.save
    end

    def find_record_by_phase(phase_id)
      admission_phase_records.find_by_admission_phase_id(phase_id) 
    end

  end
end
