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
      @score = Gaku::Grading::Collection::Score.new(@exam, @students).grade

      respond_with @exam
    end

  end
end
