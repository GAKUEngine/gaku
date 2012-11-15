module Gaku
  module Admin
    class AdmissionPeriodsController < GakuController

      inherit_resources 
      actions :index, :show, :new, :create, :update, :edit, :destroy
      
      respond_to :js, :html

      before_filter :admission_periods_count, :only => [:create, :destroy]

      def show_methods
        @admission_period = AdmissionPeriod.find(params[:id])
        @admission_methods = @admission_period.admission_methods
      end


      private
        def admission_periods_count 
          @admission_periods_count = AdmissionPeriod.count
        end
   
    end
  end
end
