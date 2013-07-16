module Gaku
  module Admin
    class AdmissionMethods::AdmissionPhasesController < GakuController

      inherit_resources
      actions :index, :show, :new, :update, :edit, :destroy

      respond_to :js, :html

      before_filter :load_admission_method
      before_filter :admission_phases_count, only: [:create, :destroy]

      def create
        @admission_phase = @admission_method.admission_phases.build(admission_phase_params)
          # @admission_phase.save  && @admission_method.admission_phases << @admission_phase

          if @admission_phase.save
            respond_to do |format|
              flash.now[:notice] = t('notice.created', resource: t('admission_phases.singular'))
              format.js { render 'create' }
            end
          end
      end

      def update
        @admission_phase = @admission_method.admission_phases.find(params[:id])
        if @admission_phase.update(admission_phase_params)
          respond_to do |format|
            flash.now[:notice] = t('notice.updated', resource: t('admission_phases.singular'))
            format.js { render 'update' }
          end
        end
      end

      def show_phase_states
        @admission_phase = AdmissionPhase.find(params[:id])
      end

      def change_default_state

      end

      def sort
        params[:'admission-method-admission-phase'].each_with_index do |id, index|
          @admission_method.admission_phases.update_all( {position: index}, {id: id} )
        end
        render nothing: true
      end

      protected

      def resource_params
        return [] if request.get?
        [params.require(:admission_phase).permit(admission_phase_attr)]
      end

      private
      
      def admission_phase_params
        params.require(:admission_phase).permit(admission_phase_attr)
      end

      def admission_phase_attr
        [:name, :position, :phase_handler, :admission_method_id, 
          { admission_phase_states_attributes: [:name, :can_progress, 
                                                :can_admit, :auto_progress,
                                                :auto_admit, :is_default, 
                                                :admission_phase_id, 
                                                :id, :_destroy]} ]
      end

      def load_admission_method
        @admission_method = AdmissionMethod.find(params[:admission_method_id])
      end

      def admission_phases_count
        @admission_phases_count = @admission_method.admission_phases.count
      end

    end
  end
end
