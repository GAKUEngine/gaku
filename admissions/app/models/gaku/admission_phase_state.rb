module Gaku
  class AdmissionPhaseState < ActiveRecord::Base
  	belongs_to :admission_phase

    attr_accessible :name, :can_progress, :can_admit, :auto_progress, :auto_admit, :is_default, :admission_phase_id

    validates  :name, presence: true
  end
end