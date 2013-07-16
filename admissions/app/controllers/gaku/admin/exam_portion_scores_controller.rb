module Gaku
  module Admin
    class ExamPortionScoresController < GakuController

      inherit_resources
      respond_to :js, :html, :json

      protected

      def resource_params
        return [] if request.get?
        [params.require(:exam_portion_score).permit(exam_portion_score_attr)]
      end

      private

      def exam_portion_score_params
        params.require(:exam_portion_score).permit(exam_portion_score_attr)
      end

      def exam_portion_score_attr
        [ :score ]
      end

    end
  end
end