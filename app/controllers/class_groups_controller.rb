class ClassGroupsController < ApplicationController

  helper_method :sort_column, :sort_direction
  
  inherit_resources
  actions :show, :new, :create, :edit, :update

  respond_to :js, :html

  before_filter :load_before_index, :only => :index
  before_filter :load_before_show, :only => :show
  before_filter :class_group,  :only => [:destroy, :show]

  def index
    @class_groups = ClassGroup.order(sort_column + " " + sort_direction)
  end

  def student_chooser
    @class_group = ClassGroup.find(params[:class_group_id])
    @search = Student.search(params[:q])
    @students = @search.result

    @class_groups = ClassGroup.all

    @enrolled_students = @class_group.students.map {|i| i.id.to_s }

    params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]

    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @class_group.destroy && !request.xhr?
      flash[:notice] = "Class Group Destroyed"  
    end
    render :nothing => true
  end
  
  private

    def class_group
      @class_group = ClassGroup.find(params[:id])
    end

    def load_before_index
      @class_group = ClassGroup.new
    end

    def load_before_show
      @notable = ClassGroup.find(params[:id])
      @course = Course.new
      @class_group_course_enrollment = ClassGroupCourseEnrollment.new
    end

    def sort_column
      ClassGroup.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

end
