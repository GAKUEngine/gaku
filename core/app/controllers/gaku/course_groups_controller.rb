module Gaku
  class CourseGroupsController < GakuController

    helper_method :sort_column, :sort_direction

    inherit_resources
    #actions :show, :new, :create, :update, :edit, :destroy
    respond_to :js, :html

    before_filter :before_show,  :only => [:show]
    before_filter :count, :only => [:create, :destroy, :index]
    before_filter :unscoped_course_group, :only => :destroy

    def index
      @course_groups = CourseGroup.order( sort_column + " " + sort_direction)
    end

    def soft_delete
      @course_group = CourseGroup.find(params[:id])
      @course_group.update_attribute('is_deleted', 'true')
      redirect_to course_groups_path, :notice => t('notice.destroyed', :resource => t('course_group.singular'))
    end

    def recovery
      unscoped_course_group
      @course_group.update_attribute('is_deleted', 'false')
      @course_groups = CourseGroup.where(:is_deleted => true)
      flash.now[:notice] = t('notice.recovered', :resource => t('course_group.singular'))
      respond_to do |format|
        format.js { render 'recovery' }
      end
    end

  	private

      def unscoped_course_group
        @course_group = CourseGroup.unscoped.find(params[:id])
      end

      def before_show
        @course_group_enrollment = CourseGroupEnrollment.new
        @courses = Course.all
      end

      def count
        @count = CourseGroup.count
      end

      def sort_column
        ClassGroup.column_names.include?(params[:sort]) ? params[:sort] : 'name'
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
      end

  end
end
