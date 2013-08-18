module Gaku
  module Admin
    class AdmissionMethodsController < GakuController

      inherit_resources
      respond_to :js, :html

      before_filter :count, only: %i(create destroy index)

      def create
        @admission_method = AdmissionMethod.new(admission_method_params)
        if @admission_method.save
          unless @admission_method.admission_phases.any?
            admission_phase = AdmissionPhase.create(name: 'Default phase', admission_method_id: @admission_method.id, phase_handler: 1)
          end
          respond_with @admission_method
        end
      end

      protected

      def resource_params
        return [] if request.get?
        [params.require(:admission_method).permit(admission_method_attr)]
      end

      private

      def admission_method_params
        params.require(:admission_method).permit(admission_method_attr)
      end

      def admission_method_attr
        %i(name starting_applicant_number)
      end

      def count
        @count = AdmissionMethod.count
      end

    end
  end
end
