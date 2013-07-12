module Gaku
  module Admin
    class AdmissionPeriodsController < GakuController

      inherit_resources
      #actions :index, :show, :new, :create, :update, :edit, :destroy

      respond_to :js, :html

      before_filter :count, only: %i(create destroy)
      before_filter :admission_methods

      def show_methods
        @admission_period = AdmissionPeriod.find(params[:id])
        @admission_methods = @admission_period.admission_methods
      end

      protected

      def resource_params
        return [] if request.get?
        [params.require(:admission_period).permit(admission_period_attr)]
      end

      private

      def admission_period_attr
        [:name, :seat_limit, :'admitted_on(1i)', :'admitted_on(2i)', :'admitted_on(3i)', :rolling, { period_method_associations_attributes: []} ]
      end

      def count
        @admission_periods_count = AdmissionPeriod.count
      end

      def admission_methods
        @admission_methods = AdmissionMethod.all(order: 'name') { |s| [s.name, s.id] }
      end

    end
  end
end
