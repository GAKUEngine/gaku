module Gaku
  module Admin
    class AdmissionMethods::AdmissionPhasesController < GakuController

      include LinkToHelper

      inherit_resources
      actions :index, :show, :new, :update, :edit, :destroy

      respond_to :js, :html

      before_filter :load_admission_method
      before_filter :admission_phases_count, :only => [:create, :destroy]
      
      def create
        super do |format|
          if @admission_phase.save  && @admission_method.admission_phases << @admission_phase 
            if !@admission_phase.admission_phase_states.any?
              admission_phase_state = AdmissionPhaseState.create(:name => "Default state",:admission_phase_id => @admission_phase.id, :is_default => true)
            else
              @admission_phase.admission_phase_states.first.update_attributes(:is_default => true)
            end
            format.js { render 'create' }
          end
        end
      end

      def show_phase_states
        @admission_phase = AdmissionPhase.find(params[:id])
      end

      def change_default_state

      end

      private
        def load_admission_method
          @admission_method = AdmissionMethod.find(params[:admission_method_id])
        end

        def admission_phases_count 
          @admission_phases_count = @admission_method.admission_phases.count
        end
    end
  end
end
