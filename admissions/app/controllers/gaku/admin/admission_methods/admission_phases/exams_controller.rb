module Gaku
  module Admin
    class AdmissionMethods::AdmissionPhases::ExamsController < GakuController

      inherit_resources

      before_filter :initialize_variables

      include LinkToHelper

      respond_to :js, :html

      def new
        @exam = @admission_phase.build_exam
        @exam.exam_portions.build
        new!
      end

      def existing
        @exams = Exam.all
      end

      def assign_existing
        @exam = Exam.find(params[:exam_id])
        @admission_phase.exam = @exam
      end

      def create
        @exam =  @admission_phase.create_exam(params[:exam])
        create!
      end

      def destroy
        @admission_phase.exam = nil
      end

      private
        def initialize_variables
          @admission_method = AdmissionMethod.find(params[:admission_method_id])
          @admission_phase = AdmissionPhase.find(params[:admission_phase_id])
        end

    end
  end
end
