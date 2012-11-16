module Gaku
  class Admission < ActiveRecord::Base
    belongs_to :student
    belongs_to :scholarship_status

    has_many :specialty_applications
    has_many :admission_methods
    has_many :admission_phase_records
    has_many :notes, as: :notable

    attr_accessible :student_id, :scholarship_status_id 
  end
end
