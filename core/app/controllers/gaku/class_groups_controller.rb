module Gaku
  class ClassGroupsController < GakuController

    include StudentChooserController

    #load_and_authorize_resource class:  ClassGroup

    respond_to :js,   only: %i( new create edit update destroy recovery )
    respond_to :html, only: %i( index edit update soft_delete )

    helper_method :sort_column, :sort_direction

    before_action :set_courses
    before_action :set_unscoped_class_group,  only: %i( destroy recovery )
    before_action :set_class_group,       only: %i( edit show update soft_delete student_chooser )

    def recovery
      @class_group.recover
      flash.now[:notice] = t(:'notice.recovered', resource: t_resource)
      respond_with @class_group
    end

    def soft_delete
      @class_group.soft_delete
      redirect_to class_groups_path,
                  notice: t(:'notice.destroyed', resource: t_resource)
    end

    def destroy
      @class_group.destroy
      set_count
      respond_with @class_group
    end

    def new
      @class_group = ClassGroup.new
      respond_with @class_group
    end

    def create
      @class_group = ClassGroup.new(class_group_params)
      @class_group.save
      set_count
      respond_with @class_group
    end

    def edit
      @class_group_course_enrollment = ClassGroupCourseEnrollment.new
    end

    def update
      @class_group.update(class_group_params)
      respond_with(@class_group) do |format|
        format.js { render }
        format.html { redirect_to [:edit, @class_group] }
      end
    end

    def index
      @class_groups = SemesterClassGroup.group_by_semester
      @class_groups_without_semester = ClassGroup.without_semester
      set_count
    end

    private

    def class_group_params
      params.require(:class_group).permit(attributes)
    end

    def attributes
      %i( name grade homeroom )
    end

    def set_class_group
      @class_group = ClassGroup.find(params[:id])
      set_notable
    end

    def set_unscoped_class_group
      @class_group = ClassGroup.unscoped.find(params[:id])
      set_notable
    end

    def t_resource
      t(:'class_group.singular')
    end

    def set_notable
      @notable = @class_group
      @notable_resource = get_resource_name @notable
    end

    def set_count
      @count = ClassGroup.count
    end

    def set_courses
      @courses = Course.includes(:syllabus).map { |c| [c, c.id] }
    end

    def sort_column
      ClassGroup.column_names.include?(params[:sort]) ? params[:sort] : 'name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

  end
end
