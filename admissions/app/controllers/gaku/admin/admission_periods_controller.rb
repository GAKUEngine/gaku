module Gaku
  module Admin
    class AdmissionPeriodsController < GakuController

      inherit_resources
      actions :index, :show, :new, :create, :update, :edit, :destroy

      respond_to :js, :html

      before_filter :admission_periods_count, :only => [:create, :destroy]
      before_filter :admission_methods

      def show_methods
        @admission_period = AdmissionPeriod.find(params[:id])
        @admission_methods = @admission_period.admission_methods
      end


      private
        def admission_periods_count
          @admission_periods_count = AdmissionPeriod.count
        end

        def admission_methods
          @admission_methods = AdmissionMethod.all(:order => 'name') { |s| [s.name, s.id] }
        end

    end
  end
end
