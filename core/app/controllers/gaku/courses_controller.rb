module Gaku
  class CoursesController < GakuController

    load_and_authorize_resource :class =>  Gaku::Course

    include StudentChooserController

    helper_method :sort_column, :sort_direction

    inherit_resources
    respond_to :js, :html

    before_filter :before_show,  :only => :show
    before_filter :count, :only => [:create, :destroy, :index]
    before_filter :load_data

    def index
      @courses = SemesterCourse.group_by_semester
      @courses_without_semester = Course.without_semester
    end

    def show
      super do |format|
        format.json { render :json => @course.as_json(:include => 'students') }
      end
    end

    protected

    def collection
      @courses = Course.includes(:syllabus).all
    end

    def resource
      @course = Course.includes(:syllabus => {:exams => :exam_portion_scores}).find(params[:id])
    end

    private

    def load_data
      @syllabuses = Syllabus.all.collect { |s| [s.name, s.id] }
    end

    def count
      @count = Course.count
    end

	  def before_show
      @notable = Course.find(params[:id])
      @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")
      @class_groups = ClassGroup.all.collect { |s| [s.name, s.id] }
	  end

    def sort_column
      Student.column_names.include?(params[:sort]) ? params[:sort] : 'surname'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

  end
end
