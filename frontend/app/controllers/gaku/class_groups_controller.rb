module Gaku
  class ClassGroupsController < GakuController

    include StudentChooserController

    #respond_to :js,   only: %i( new create destroy recovery )
    #respond_to :html, only: %i( index edit update soft_delete )

    respond_to :html, :js

    before_action :set_courses
    before_action :set_class_group,       only: %i( edit update destroy student_chooser student_selection )

    def student_selection
      @student_selection = current_user.student_selection
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
      respond_with @class_group, location: [:edit, @class_group]
    end

    def index
      @semesters = Semester.with_class_group.active.includes(:class_groups)
      @count = @semesters.count
    end

    def with_semester
      @semesters = Semester.with_class_group.includes(:class_groups)
      @count = @semesters.count
      render :with_semester, layout: 'gaku/layouts/index'
    end

    def without_semester
      @class_groups = ClassGroup.without_semester.includes(:semester_class_groups)
      @count = @class_groups.count
      render :without_semester, layout: 'gaku/layouts/index'
    end

    def advanced_search
      @semesters = Semester.with_class_group.collect{|p| [p.to_s, p.id]}
      @search = ClassGroup.search(params[:q])
      results = @search.result(distinct: true)
      @class_groups = results.page(params[:page])
    end

    def semester_advanced_search
      @search = Semester.with_class_group.includes(:class_groups).search(params[:q])
      results = @search.result(distinct: true)
      @semesters = results.page(params[:page])
      @semesters_for_select = Semester.with_class_group.collect{|p| [p.to_s, p.id]}
    end

    def search_semester
      @search = Semester.includes(:class_groups).search(params[:q])
      results = @search.result(distinct: true)
      @semesters = results.page(params[:page])
      @count = results.count
      render :with_semester, layout: 'gaku/layouts/index'
    end

    def search
      @semesters = Semester.with_class_group.collect{|p| [p.to_s, p.id]}
      @search = ClassGroup.without_semester.search(params[:q])
      results = @search.result(distinct: true)
      @class_groups = results.page(params[:page])
      @count = results.count
      render :without_semester, layout: 'gaku/layouts/index'
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
