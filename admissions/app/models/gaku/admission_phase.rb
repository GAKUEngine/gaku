module Gaku
  class AdmissionPhase < ActiveRecord::Base

    belongs_to :admission_method
  	has_many :admission_phase_records
    has_many :exams
  	has_many :admission_phase_states
    accepts_nested_attributes_for :admission_phase_states, :allow_destroy => true
    has_one  :exam

    attr_accessible :name, :order, :phase_handler, :admission_method_id, :admission_phase_states_attributes

    validates :name, :presence => true
  end
end