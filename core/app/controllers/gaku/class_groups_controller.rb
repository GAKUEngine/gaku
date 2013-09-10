module Gaku
  class ClassGroupsController < GakuController

    include StudentChooserController

    load_and_authorize_resource class:  ClassGroup

    respond_to :js, :html

    helper_method :sort_column, :sort_direction

    inherit_resources

    before_filter :load_data
    before_filter :load_before_show, only: :show
    before_filter :count, only: %i(create destroy index)

    def index
      @class_groups = SemesterClassGroup.group_by_semester
      @class_groups_without_semester = ClassGroup.without_semester
    end

    protected

    def resource_params
      return [] if request.get?
      [params.require(:class_group).permit(attributes)]
    end

    private

    def attributes
      %i(name grade homeroom)
    end

    def load_data
      @courses = Course.includes(:syllabus).map { |c| [c, c.id] }
    end

    def load_before_show
      @notable = ClassGroup.find(params[:id])
      @notable_resource = get_resource_name(@notable)
      @class_group_course_enrollment = ClassGroupCourseEnrollment.new
    end

    def sort_column
      ClassGroup.column_names.include?(params[:sort]) ? params[:sort] : 'name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

    def count
      @count = ClassGroup.count
    end

  end
end
