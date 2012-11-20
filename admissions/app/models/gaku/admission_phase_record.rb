module Gaku
  class AdmissionPhaseRecord < ActiveRecord::Base
    belongs_to :admission
    belongs_to :admission_phase
    belongs_to :admission_phase_state
    has_many :exam_scores
    has_many :notes

    attr_accessible :admission_id, :admission_phase_id, :admission_phase_state_id
  end
end