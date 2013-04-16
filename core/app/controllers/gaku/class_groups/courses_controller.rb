module Gaku
  class ClassGroups::CoursesController < GakuController

    load_and_authorize_resource :class_group, :class => Gaku::ClassGroup
    load_and_authorize_resource :course, :through => :class_group, :class => Gaku::Course

    inherit_resources
    respond_to :html, :js

    before_filter :class_group, :only => [:new, :create, :edit, :update, :destroy]
    before_filter :count, :only => [:create, :destroy]

    def destroy
      @class_group_course_enrollment = ClassGroupCourseEnrollment.find(params[:id])
      @class_group_course_enrollment.destroy
      respond_with @class_group_course_enrollment
    end

    def create
      @class_group_course_enrollment = ClassGroupCourseEnrollment.new(params[:class_group_course_enrollment])
      if @class_group_course_enrollment.save
      	respond_with @class_group_course_enrollment
      end
    end

    def new
      @course = Course.new
      @class_group_course_enrollment = ClassGroupCourseEnrollment.new
    end

    private

    def class_group
      @class_group = ClassGroup.find(params[:class_group_id])
    end

    def count
      @count = @class_group.courses.count
    end

  end
end
