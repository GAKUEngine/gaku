module Gaku
  class AdmissionPhaseRecord < ActiveRecord::Base
    belongs_to :admission
    belongs_to :admission_phase
    belongs_to :admission_phase_state
    has_many :exam_scores
    has_many :notes, as: :notable

    attr_accessible :admission_id, :admission_phase_id, :admission_phase_state_id
  
    default_scope where("is_deleted = ?", false)
    scope :deleted, where("is_deleted = ?", true)
    
  end
end