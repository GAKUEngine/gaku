module Gaku
  module Api
    module V1
      module Courses
        module Exams
          class ExamPortionScoresController < BaseController
            skip_before_action :authenticate_request
            before_action :set_exam
            before_action :set_exam_portion_score

            def update
              @exam_portion_score.update(exam_portion_score_params)
              @gradable_scope = Course.find params[:course_id]

              grading_methods = @gradable_scope.grading_methods
              student = Gaku::Student.first

              calculations = Grading::Collection::Calculations.new(
                grading_methods,
                @gradable_scope.students,
                @exam,
                @gradable_scope
              ).calculate

              ActionCable.server.broadcast("exam_#{@exam.id}", {
                calculations: calculations
              }
                )
              head :ok
            end

            private

            def exam_portion_score_params
              params.require(:score)
              params.permit(:score)
            end

            def set_exam_portion_score
              @exam_portion_score = Gaku::ExamPortionScore.find(params[:id])
            end

            def set_exam
              @exam = Gaku::Exam.find(params[:exam_id])
            end

          end
        end
      end
    end
  end
end
