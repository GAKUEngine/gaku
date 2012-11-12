module Gaku
  class AdmissionPhaseRecord < ActiveRecord::Base
    belongs_to :admission
    belongs_to :admission_phase
    has_many :exam_scores

    attr_accessible :admission_id, :admission_phase_id
  end
end