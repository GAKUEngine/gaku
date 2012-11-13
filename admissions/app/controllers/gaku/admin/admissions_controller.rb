module Gaku
  module Admin
    class AdmissionsController < GakuController

      inherit_resources
      respond_to :js, :html

      helper_method :sort_column, :sort_direction

      before_filter :load_before_index, :only => [:index, :change_admission_period, :change_admission_method]
      before_filter :load_state_records, :only => [:index, :change_admission_period, :change_admission_method]
      before_filter :load_search_object

      def change_admission_period
        @admission_period = AdmissionPeriod.find(params[:admission_period])
        @admission_methods = @admission_period.admission_methods
      end

      def change_admission_method
        @admission_method = AdmissionMethod.find(params[:admission_method])
      end

      def index
        
        #raise @students.find_all { |h| h[:state_id] == 1 }.map { |i| i[:student] }.inspect
        #raise @students.inspect
      end

      private
        def load_before_index
        	@search = Student.search(params[:q])
          @students = @search.result
          @class_groups = ClassGroup.all
          @courses = Course.all
          @admission_periods = Gaku::AdmissionPeriod.all
          @admission_period = @admission_periods.last
          @admission_methods = @admission_periods.last.admission_methods
          @admission_method = @admission_period.admission_methods.first
        end

        def load_search_object
          @search = Student.search(params[:q])
        end

        def load_state_records
          @students = []
          @state_records = AdmissionPhaseRecord.all
          @state_records.each {|record|
            @students << {
              :state_id => record.admission_phase_state_id,
              :student => record.admission.student
            }
          }
        end

        def sort_column
          Student.column_names.include?(params[:sort]) ? params[:sort] : "surname"
        end

        def sort_direction
          %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
        end
    end
  end
end
