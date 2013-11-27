module Gaku
  class ClassGroups::CoursesController < GakuController

    respond_to :js, only: %i( new create destroy )

    before_action :set_class_group
    before_action :set_enrollment, only: %i( destroy )

    def new
      @class_group_course_enrollment = ClassGroupCourseEnrollment.new
    end

    def create
      @class_group_course_enrollment = ClassGroupCourseEnrollment.new(class_group_course_enrollment_params)
      @class_group_course_enrollment.save
      set_count
      respond_with @class_group_course_enrollment
    end

    def destroy
      @class_group_course_enrollment.destroy
      set_count
      respond_with @class_group_course_enrollment
    end


    private

    def class_group_course_enrollment_params
      params.require(:class_group_course_enrollment).permit(attributes)
    end

    def attributes
      %i( course_id class_group_id )
    end

    def set_enrollment
      @class_group_course_enrollment = ClassGroupCourseEnrollment.find(params[:id])
    end

    def set_class_group
      @class_group = ClassGroup.find(params[:class_group_id])
    end

    def set_count
      @count = @class_group.courses.count
    end

  end
end
