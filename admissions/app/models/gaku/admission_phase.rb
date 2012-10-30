module Gaku
  class AdmissionPhase < ActiveRecord::Base
  	has_many :admission_phase_records
  	has_many :admission_phase_states
  	belongs_to :admission_method

    attr_accessible :name, :order, :phase_handler, :admission_method_id
  end
end