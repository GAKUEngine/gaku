module Gaku
  module Admin
    class AdmissionMethods::AdmissionPhases::AdmissionPhaseStatesController < GakuController

      include LinkToHelper

      respond_to :js, :html

      def make_default
        @state = AdmissionPhaseState.find(params[:id])
        @phase = AdmissionPhase.find(params[:admission_phase_id])
        @phase.admission_phase_states.each {|state|
          state.is_default = false
          state.save
        }
        @state.is_default = true
        @state.save
      end

    end
  end
end
