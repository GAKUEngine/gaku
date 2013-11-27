module Gaku
  class CoursesController < GakuController

    include StudentChooserController

    helper_method :sort_column, :sort_direction

    respond_to :js,   only: %i( new create destroy recovery )
    respond_to :html, only: %i( index edit update show soft_delete show_deleted )

    before_action :set_course,   only: %i( edit show update soft_delete student_chooser )
    before_action :set_unscoped_course, only: %i( show_deleted destroy recovery )
    before_action :set_syllabuses

    def destroy
      @course.destroy
      set_count
      respond_with @course
    end

    def recovery
      @course.recover
      respond_with @course
    end

    def soft_delete
      @course.soft_delete
      respond_with @course, location: courses_path
    end

    def show_deleted
      render :show
    end

    def new
      @course = Course.new
      respond_with @course
    end

    def create
      @course = Course.new(course_params)
      @course.save
      set_count
      respond_with @course
    end

    def edit
      set_class_groups
    end

    def show
      #format.json { render json: @course.as_json(include: :students) }
    end

    def update
      @course.update(course_params)
      respond_with @course, location: [:edit, @course]
    end

    def index
      @courses = SemesterCourse.group_by_semester
      @courses_without_semester = Course.without_semester
      #@courses = Course.includes(:syllabus).all
      set_count
      respond_with @courses
    end

    private

    def course_params
      params.require(:course).permit(attributes)
    end

    def attributes
      %i( syllabus_id code )
    end

    def set_course
      @course = Course.includes(syllabus: {exams: :exam_portion_scores}).find(params[:id])
      set_notable
    end

    def set_unscoped_course
      @course = Course.unscoped.includes(syllabus: {exams: :exam_portion_scores}).find(params[:id])
    end

    def set_notable
      @notable = @course
      @notable_resource = get_resource_name @notable
    end

    def set_count
      @count = Course.count
    end

    def set_syllabuses
      @syllabuses = Syllabus.all
    end

    def set_class_groups
      @class_groups = ClassGroup.all
    end

    def sort_column
      Student.column_names.include?(params[:sort]) ? params[:sort] : 'surname'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

  end
end
