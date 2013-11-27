module Gaku
  class Courses::SemesterCoursesController < GakuController

    respond_to :js, only: %i( new create edit update destroy )

    before_action :set_course
    before_action :set_semester_course, only: %i( edit update destroy )
    before_action :set_semesters, only: %i( new edit )

    def new
      @semester_course = SemesterCourse.new
      respond_with @semester_course
    end

    def create
      @semester_course = @course.semester_courses.build(semester_course_params)
      @semester_course.save
      set_count
      respond_with @semester_course
    end

    def edit
    end

    def update
      @semester_course.update(semester_course_params)
      respond_with @semester_course
    end

    def destroy
      @semester_course.destroy
      set_count
      respond_with @semester_course
    end


    private

    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_semester_course
      @semester_course = SemesterCourse.find(params[:id])
    end

    def semester_course_params
      params.require(:semester_course).permit(attributes)
    end

    def attributes
      %i( semester_id )
    end

    def set_count
      @count = @course.semesters.count
    end

    def set_semesters
      @semesters = Semester.all
    end

  end
end
