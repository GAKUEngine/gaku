module Gaku
  class AdmissionPhase < ActiveRecord::Base
  	has_many :admission_phase_records
  	has_many :admission_phase_states
    accepts_nested_attributes_for :admission_phase_states, :allow_destroy => true

  	belongs_to :admission_method

    attr_accessible :name, :order, :phase_handler, :admission_method_id, :admission_phase_states_attributes
  end
end