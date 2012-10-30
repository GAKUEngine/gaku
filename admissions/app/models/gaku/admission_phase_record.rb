module Gaku
  class AdmissionPhaseRecord < ActiveRecord::Base
    belongs_to :admission
    belongs_to :admission_phase

    attr_accessible :admission_id, :admission_phase_id
  end
end