module Gaku
  class ExamPortionScoresController < GakuController

    respond_to :js

    before_action :set_resource, only: :update
    before_action :set_exam, only: :update

    def update
      exam_portion_score = ExamPortionScore.find(params[:id])
      exam_portion_score.update_attributes(exam_portion_score_params)

      student         = exam_portion_score.student
      grading_methods = @gradable_scope.grading_methods

      calculations = Grading::Single::Calculations.new(grading_methods, student, @exam, @gradable_scope, @gradable_scope.students).calculate
      message = {
                  exam_id: @exam.id,
                  gradable_type: gradable_type,
                  gradable_id: @gradable_scope.id,
                  calculations: calculations,
                  exam_portion_score: exam_portion_score,
                  exam_portion_score_type: exam_portion_score.exam_portion.score_type
                }

      $redis.publish('grading-change', message.to_json)

      render nothing: true
    end

    private

    def exam_portion_score_params
      params.require(:exam_portion_score).permit(attributes)
    end

    def attributes
      %i( score score_text score_selection )
    end

    def set_resource
      @gradable_scope = "gaku/#{request_path_array[1]}".classify.constantize.find(request_path_array[2])
    end

    def set_exam
      @exam = Exam.find(params[:exam_id])
    end

    def request_path_array
      request.path.split('/')
    end

    def gradable_type
      @gradable_scope.class.to_s.demodulize.underscore.dasherize
    end


  end
end
