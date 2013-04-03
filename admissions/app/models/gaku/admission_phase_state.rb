module Gaku
  class AdmissionPhaseState < ActiveRecord::Base
  	belongs_to :admission_phase
    has_many   :admission_phase_records

    attr_accessible :name, :can_progress, :can_admit, :auto_progress,
                    :auto_admit, :is_default, :admission_phase_id

    validates  :name, presence: true, :uniqueness => {:scope => :admission_phase_id}

    before_destroy { |state| 
      admission_phase = state.admission_phase
      states = admission_phase.admission_phase_states.where('id != ?', state.id)
      default_state = states.find_by_is_default(true)
      if default_state.nil? 
        if states.any?
          default_state = admission_phase.admission_phase_states.where('id != ?', state.id).first
          default_state.is_default = true
          default_state.name = default_state.name + "(Default state)"
          default_state.save
        else
          default_state = AdmissionPhaseState.create(:is_default => true, :admission_phase_id => admission_phase.id, :name => "Default state")
        end
      end
        
      
      state.admission_phase_records.each {|record|
        record.update_attributes(:admission_phase_state_id => default_state.id)
      }
    }
  end
end
