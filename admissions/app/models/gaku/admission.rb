module Gaku
  class Admission < ActiveRecord::Base
    belongs_to :student
    accepts_nested_attributes_for :student
    belongs_to :scholarship_status
    belongs_to :admission_method
    belongs_to :admission_period

    has_many :specialty_applications
    has_many :admission_phase_records
    accepts_nested_attributes_for :admission_phase_records, :allow_destroy => true
    has_many :exam_scores
    has_many :attachments, as: :attachable
    has_many :notes, as: :notable

    has_one :school_history

    attr_accessible :student_id, :scholarship_status_id , :admission_method_id, :admission_period_id, :student_attributes
  end
end