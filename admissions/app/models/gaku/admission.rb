module Gaku
  class Admission < ActiveRecord::Base
    belongs_to :student
    belongs_to :scholarship_status

    has_many :past_schools
    has_many :specialty_applications
    has_many :admission_methods
    has_many :admission_phase_records
  end
end
