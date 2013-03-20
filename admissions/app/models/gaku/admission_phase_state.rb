module Gaku
  class AdmissionPhaseState < ActiveRecord::Base
  	belongs_to :admission_phase
    has_many   :admission_phase_records

    attr_accessible :name, :can_progress, :can_admit, :auto_progress,
                    :auto_admit, :is_default, :admission_phase_id

    validates  :name, presence: true, :uniqueness => {:scope => :admission_phase_id}

    before_destroy { |state| 
      admission_phase = state.admission_phase
      default_state = admission_phase.admission_phase_states.find_by_is_default(true)
      state.admission_phase_records.each {|record|
        record.update_attributes(:admission_phase_state_id => default_state.id)
      }
    }
  end
end
