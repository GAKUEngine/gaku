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

    has_one :school_history

    accepts_nested_attributes_for :admission_phase_records, :allow_destroy => true
    accepts_nested_attributes_for :student

    attr_accessible :student_id, :applicant_number, :scholarship_status_id,
                    :admission_method_id, :admission_period_id,
                    :student_attributes, :admitted

    #validates :applicant_number, :presence => true, :uniqueness => {:scope => :admission_method_id}

    def student
      Student.unscoped{ super }
    end

  end
end
