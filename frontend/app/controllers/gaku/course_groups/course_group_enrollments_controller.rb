module Gaku
  class CourseGroups::CourseGroupEnrollmentsController < GakuController

    respond_to :js, only: %i( new create destroy index )

    before_action :set_course_group
    before_action :set_course_group_enrollment, only: :destroy
    before_action :set_courses, only: :new

    def index

    end

    def new
      @course_group_enrollment = CourseGroupEnrollment.new
      respond_with @course_group_enrollment
    end

    def create
      @course_group_enrollment = CourseGroupEnrollment.new(course_group_enrollment_params)
      if @course_group_enrollment.save
        flash.now[:notice] = t(:'notice.added', resource: t(:'course.singular'))
        set_count
        respond_with @course_group_enrollment
      else
        render :error
      end
    end

    def destroy
      @course_group_enrollment.destroy
      set_count
      respond_with @course_group_enrollment
    end

    private

    def attributes
      %i( course_id course_group_id )
    end

    def course_group_enrollment_params
      params.require(:course_group_enrollment).permit(attributes)
    end

    def set_course_group
      @course_group = CourseGroup.find(params[:course_group_id])
    end

    def set_course_group_enrollment
      @course_group_enrollment = CourseGroupEnrollment.find(params[:id])
    end

    def set_courses
      @courses = Course.all
    end

    def set_count
      @count = @course_group.courses.count
    end

  end
end
