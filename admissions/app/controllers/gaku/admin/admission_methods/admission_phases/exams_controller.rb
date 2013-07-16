module Gaku
  module Admin
    class AdmissionMethods::AdmissionPhases::ExamsController < GakuController

      inherit_resources

      before_filter :load_data
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
        @exam =  @admission_phase.create_exam(exam_params)
        create!
      end

      def destroy
        @admission_phase.exam = nil
      end

      protected

      def resource_params
        return [] if request.get?
        [params.require(:exam).permit(exam_attr)]
      end

      private

      def exam_params
        params.require(:exam).permit(exam_attr)
      end

      def exam_attr
        [:name, :weight, :description, :adjustments, :use_weighting, { exam_portions_attributes: []}]
      end

      def load_data
        @admission_method = AdmissionMethod.find(params[:admission_method_id])
        @admission_phase = AdmissionPhase.find(params[:admission_phase_id])
        @grading_methods = GradingMethod.all.collect { |s| [s, s.id] }
      end

    end
  end
end
