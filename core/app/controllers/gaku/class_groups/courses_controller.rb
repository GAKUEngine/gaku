module Gaku
  class ClassGroups::CoursesController < GakuController

    #load_and_authorize_resource :class_group, class: Gaku::ClassGroup
    #load_and_authorize_resource :course,
    #                            through: :class_group,
    #                            class: Gaku::Course

    inherit_resources

    defaults resource_class: ClassGroupCourseEnrollment,
             instance_name: 'class_group_course_enrollment'

    respond_to :html, :js

    before_filter :class_group, only: [:new, :create, :edit, :update, :destroy]
    before_filter :count,       only: [:create, :destroy]

    protected

    def resource_params
      return [] if request.get?
      [params.require(:class_group_course_enrollment).permit(class_group_course_enrollment_attr)]
    end

    private

    def class_group_course_enrollment_attr
      %i(course_id class_group_id)
    end

    def class_group
      @class_group = ClassGroup.find(params[:class_group_id])
    end

    def count
      @count = @class_group.courses.count
    end

  end
end
