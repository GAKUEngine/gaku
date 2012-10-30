module Gaku
  class CoursesController < ApplicationController
  	
    helper_method :sort_column, :sort_direction

    inherit_resources
    actions :index, :show, :new, :create, :update, :edit, :destroy

    respond_to :js, :html

    before_filter :load_before_show,  :only => :show
    before_filter :load_before_index, :only => :index
    before_filter :courses_count, :only => [:create, :destroy]

    def create
      super do |format|
        format.js { render 'create' }
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

      @enrolled_students = @course.students.map {|i| i.id.to_s }

      params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]

      respond_to do |format|
        format.js
      end
    end
    
    def destroy
      super do |format|
        format.js { render 'destroy' }
      end
    end

    private
      
      def load_before_index
        @course = Course.new
        @syllabuses = Syllabus.all
      end

  	  def load_before_show
  		  @new_course_enrollment = CourseEnrollment.new
        @class_groups = ClassGroup.all
        @notable = Course.find(params[:id])
        @notable_resource = @notable.class.to_s.underscore.gsub("_","-")
  	  end

      def courses_count
        @courses_count = Course.count
      end

      def sort_column
        Student.column_names.include?(params[:sort]) ? params[:sort] : 'surname'
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
      end

  end
end
