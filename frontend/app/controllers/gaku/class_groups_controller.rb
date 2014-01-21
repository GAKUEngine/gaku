module Gaku
  class ClassGroupsController < GakuController

    include StudentChooserController

    #respond_to :js,   only: %i( new create destroy recovery )
    #respond_to :html, only: %i( index edit update soft_delete )

    respond_to :html, :js

    before_action :set_courses
    before_action :set_class_group,       only: %i( edit update destroy student_chooser )


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
      respond_with @class_group, location: [:edit, @class_group]
    end

    def index
      @search = ClassGroup.without_semester.search(params[:q])
      results = @search.result(distinct: true)
      @class_groups = results.page(params[:page])
      set_count
    end

    def with_semesters
      @class_groups = SemesterClassGroup.group_by_semester
      @count = @class_groups.count
      render :with_semesters, layout: 'gaku/layouts/index'
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

    def set_notable
      @notable = @class_group
      @notable_resource = get_resource_name @notable
    end

    def set_count
      @count = ClassGroup.count
    end

    def set_courses
      @courses = Course.all.map { |c| [c, c.id] }
    end

  end
end
