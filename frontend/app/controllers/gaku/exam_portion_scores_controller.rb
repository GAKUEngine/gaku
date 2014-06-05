module Gaku
  class ExamPortionScoresController < GakuController

    respond_to :js

    before_action :set_course, only: :update
    before_action :set_exam, only: :update

    def update
      exam_portion_score = ExamPortionScore.find(params[:id])
      exam_portion_score.update_attributes(exam_portion_score_params)

      student         = exam_portion_score.student
      grading_methods = @course.grading_methods

      calculations = Grading::Single::Calculations.new(grading_methods, student, @exam).calculate
      message = {
                  exam_id: @exam.id,
                  course_id: @course.id,
                  calculations: calculations,
                  exam_portion_score: exam_portion_score
                }
      $redis.publish('grading-change', message.to_json)

      render nothing: true
    end

    private

    def exam_portion_score_params
      params.require(:exam_portion_score).permit(attributes)
    end

    def attributes
      %i( score )
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_exam
      @exam = Exam.find(params[:exam_id])
    end

  end
end
