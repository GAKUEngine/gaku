module Gaku
  class Admission < ActiveRecord::Base
    belongs_to :student
    has_many :admission_methods
    has_many :admission_phase_records
  end
end
