module Gaku
  class ClassGroups::CoursesController < GakuController

    load_and_authorize_resource :class_group, class: ClassGroup
    load_and_authorize_resource :course,
                                through: :class_group,
                                class: Course

    respond_to :html, :js

    inherit_resources

    defaults resource_class: ClassGroupCourseEnrollment,
             instance_name: 'class_group_course_enrollment'



    before_filter :class_group, only: %i(new create edit update destroy)
    before_filter :count,       only: %i(create destroy)

    protected

    def resource_params
      return [] if request.get?
      [params.require(:class_group_course_enrollment).permit(attributes)]
    end

    private

    def attributes
      %i(course_id class_group_id)
    end

    def class_group
      @class_group = ClassGroup.find(params[:class_group_id])
    end

    def count
      @class_group = ClassGroup.find(params[:class_group_id])
      @count = @class_group.courses.count
    end

  end
end
