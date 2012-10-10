class CoursesController < ApplicationController
	
  helper_method :sort_column, :sort_direction

  before_filter :load_before_show, :only => :show
  before_filter :load_before_index, :only => :index
  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def create
    super do |format|
      flash.now[:notice] = t('courses.course_created')
      format.js { render }
    end
  end

  def show
    super do |format|
      format.json { render :json => @course.as_json(:include => 'students') }
    end
  end

  def student_chooser
    @course = Course.find(params[:course_id])
    @search = Student.search(params[:q])
    @students = @search.result

    @courses = Course.all

    params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]

    respond_to do |format|
      format.js
    end
  end

  def destroy
    super do |format|
      format.js { render :nothing => true}
    end

  end

  private
    
    def load_before_index
      @course = Course.new
    end

	  def load_before_show
		  @new_course_enrollment = CourseEnrollment.new
	  end

    def sort_column
      Student.column_names.include?(params[:sort]) ? params[:sort] : "surname"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

end
