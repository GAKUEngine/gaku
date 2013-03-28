module Gaku
  module Admin
    class AdmissionMethodsController < GakuController

      inherit_resources
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy, :index]

      def default_phase
        { 
          name: "Default phase",
          admission_method_id: @admission_method.id,
          phase_handler: 1
        }
      end

      def default_phase_state
        { 
          name: "Default state",
          admission_phase_id: admission_phase.id, 
          is_default: true,
          can_progress: true,
          auto_admit: false
        }
      end
      
      def create
        @admission_method = AdmissionMethod.new(params[:admission_method])
          

          if @admission_method.save
            if !@admission_method.admission_phases.any?
              admission_phase = AdmissionPhase.create(default_phase)
              admission_phase_state = AdmissionPhaseState.create(default_phase_state)
              admission_phase.admission_phase_states << admission_phase_state
            end
            respond_to do |format|
              flash.now[:notice] = t('notice.created', :resource => t('admission_phases.singular'))
              format.js { render 'create' }
            end
          end
      end

      private
        def count
          @count = AdmissionMethod.count
        end
    end
  end
end
