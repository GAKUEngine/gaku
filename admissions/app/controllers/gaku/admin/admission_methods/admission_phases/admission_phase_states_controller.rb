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

      def edit
        @state = AdmissionPhaseState.find(params[:id])
        @admission_method = AdmissionMethod.find(params[:admission_method_id])
        @admission_phase = AdmissionPhase.find(params[:admission_phase_id])
      end

      def update
        @state = AdmissionPhaseState.find(params[:id])
        if @state.update_attributes(params[:admission_phase_state])
          respond_to do |format|
            format.js { render 'update' }
          end
        end
      end

    end
  end
end
