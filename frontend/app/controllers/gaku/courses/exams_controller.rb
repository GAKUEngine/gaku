module Gaku
  class Courses::ExamsController < GakuController

    respond_to :html
    respond_to :js, only: :index

    def index
      @course = Course.find(params[:course_id])
      respond_with @course
    end

    def grading
      @course = Course.find(params[:course_id])
      @exam = Exam.includes(exam_portions: :exam_portion_scores).find(params[:id])
      @students = @course.students
      @grading_methods = @course.grading_methods
      @gradable_scope = @course
      init_portion_scores

      @grading_calculations = Grading::Collection::Calculations.new(@grading_methods, @students, @exam, @gradable_scope).calculate

      render 'gaku/shared/grading/grading'
    end

    private

    def init_portion_scores
      @students.each do |student|
        @exam.exam_portions.each do |portion|
          portion.exam_portion_scores.where(student: student, gradable: @gradable_scope).first_or_create
        end
      end
    end

  end
end
