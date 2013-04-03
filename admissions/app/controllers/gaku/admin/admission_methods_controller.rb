module Gaku
  module Admin
    class AdmissionMethodsController < GakuController

      inherit_resources
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy, :index]
      before_filter :admission_method, :only => [:create]
      
      def create
        if @admission_method.save
          if !@admission_method.admission_phases.any?
            admission_phase = AdmissionPhase.create(name: "Default phase", admission_method_id: @admission_method.id, phase_handler: 1)
            #admission_phase_state = AdmissionPhaseState.create(@default_phase_data)
            #admission_phase.admission_phase_states << @phase_state_data
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

        def admission_method
          @admission_method = AdmissionMethod.new(params[:admission_method])
        end
    end
  end
end
