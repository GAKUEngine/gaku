module Gaku
  class CourseGroupsController < GakuController

    load_and_authorize_resource class: Gaku::CourseGroup

    helper_method :sort_column, :sort_direction

    inherit_resources
    #actions :show, :new, :create, :update, :edit, :destroy
    respond_to :js, :html

    before_filter :before_show,  only: [:show]
    before_filter :count, only: [:create, :destroy, :index]
    before_filter :unscoped_course_group, only: :destroy
    before_filter :load_data

    def index
      @course_groups = CourseGroup.order(sort_column + ' ' + sort_direction)
    end

    def soft_delete
      @course_group = CourseGroup.find(params[:id])
      @course_group.update_attribute(:deleted, true)
      redirect_to course_groups_path,
                  notice: t(:'notice.destroyed', resource: t_resource)
    end

    def recovery
      unscoped_course_group
      @course_group.update_attribute(:deleted, false)
      @course_groups = CourseGroup.where(deleted: true)
      flash.now[:notice] = t(:'notice.recovered', resource: t_resource)
      respond_to do |format|
        format.js { render :recovery }
      end
    end

    def resource_params
      return [] if request.get?
      [params.require(:course_group).permit(course_group_attr)]
    end

    private

    def course_group_attr
      %i(name code)
    end

    private

    def t_resource
      t(:'course_group.singular')
    end

    def unscoped_course_group
      @course_group = CourseGroup.unscoped.find(params[:id])
    end

    def load_data
      @courses = Course.includes(:syllabus).map { |c| [c, c.id] }
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
