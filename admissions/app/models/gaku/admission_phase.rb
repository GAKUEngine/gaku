module Gaku
  class AdmissionPhase < ActiveRecord::Base
  	has_many :admission_phase_records
    attr_accessible :name, :order, :phase_handler
  end
end