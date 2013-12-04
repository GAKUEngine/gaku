module Gaku
  CourseGroupsController.class_eval do

    def recovery
      @course_group = CourseGroup.deleted.find(params[:id])
      @course_group.recover
      respond_with @course_group
    end

    def soft_delete
      @course_group = CourseGroup.find(params[:id])
      @course_group.soft_delete
      respond_with @course_group, location: course_groups_path
    end

  end
end
