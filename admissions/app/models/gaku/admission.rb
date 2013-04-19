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

    #validates: :applicant_number, :uniqueness => {:scope => [:admission_period_id, :admission_method_id]}

    def self.progress_students(students, phase)
      progress_success = []
      students.each  do |student|
        success = student.admission.progress_to_next_phase(phase)
        if success
          progress_success << student.id
        end
      end
      return progress_success
    end

    def self.remove_students(students, phase)
      remove_success = []
      students.each  do |student|
        record = student.admission.admission_phase_records.find_by_admission_phase_id(phase.id)
        success = record.update_attributes(:is_deleted => true)
        if success
          remove_success << student.id
        end
      end
      return remove_success
    end

    def self.change_students_state(students, phase, old_state, next_state)
      progress_success = false
      students.each  do |student|
        admission_record = student.admission.find_record_by_phase(phase.id)
        unless (next_state.id == old_state.id)
          if next_state.auto_admit == true
            student.admission.admit(student)
          elsif next_state.auto_progress == true
            progress_success = student.admission.progress_to_next_phase(phase)
          end
          admission_record.admission_phase_state_id = next_state.id
          admission_record.save
        end
      end
      return progress_success
    end

    def assign_admission_phase_record(admission_phase, admission_phase_state)
      admission_phase_record = AdmissionPhaseRecord.create(
                                                :admission_phase_id => admission_phase.id,
                                                :admission_phase_state_id => admission_phase_state.id,
                                                :admission_id => self.id)

      update_column(:admission_phase_record_id, admission_phase_record.id)
      return admission_phase_record
    end

    def self.create_multiple_admissions(students, admission_period, admission_method, applicant_number)
      err_admissions = []
      admissions = []
      admission_records = []
      result = {}
      students.each { |student|
        student_id = student.split("-")[1].to_i
        admission = Admission.new( admission_period_id: admission_period.id,
                                    admission_method_id: admission_method.id,
                                    student_id: student_id,
                                    applicant_number: applicant_number )
        if  admission.save
          admissions << admission
          # TODO change the selected phase
          admission_phase = admission.admission_method.admission_phases.first
          admission_phase_state = admission_phase.get_default_state
          result[:admission_phase_state] = admission_phase_state
          admission_records << admission.assign_admission_phase_record(admission_phase, admission_phase_state)
          admission.change_student_to_applicant
          applicant_number += 1
        else
          err_admissions << admission
        end
      }
      result[:admissions] = admissions
      result[:admission_records] =  admission_records
      result[:err_admissions] = err_admissions 
      return result
    end

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

      student.admission.update_attribute(:admitted, true)
      student.make_admitted(admission_date)
    end

    def progress_to_next_phase(phase)
      next_phase = AdmissionPhase.find_next_phase(phase)
      new_state = next_phase.admission_phase_states.first
      success = false

      record = AdmissionPhaseRecord.deleted.find_by_admission_id_and_admission_phase_id_and_admission_phase_state_id(student.admission.id, next_phase.id, new_state.id)
      if !record.nil?
        success = record.update_attributes(:is_deleted => false)
      else
        record = AdmissionPhaseRecord.new
        record.admission = student.admission
        record.admission_phase = next_phase
        record.admission_phase_state = new_state
        success = record.save
      end
      return success
    end

    def find_record_by_phase(phase_id)
      admission_phase_records.find_by_admission_phase_id(phase_id)
    end

  end
end
