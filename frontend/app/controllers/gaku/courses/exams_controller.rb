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
      @exam = Exam.find(params[:id])
      @students = @course.students
      @grading_methods = @course.grading_methods
      @gradable_scope = @course

      @grading_calculations = Grading::Collection::Calculations.new(@grading_methods, @students, @exam, @gradable_scope).calculate

      render 'gaku/shared/grading/grading'
    end

  end
end
