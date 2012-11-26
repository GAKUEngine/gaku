module Gaku
  class CoursesController < GakuController

    helper_method :sort_column, :sort_direction

    inherit_resources
    #actions :index, :show, :new, :create, :update, :edit, :destroy
    respond_to :js, :html

    before_filter :before_show,  :only => :show
    before_filter :before_index, :only => :index
    before_filter :count, :only => [:create, :destroy, :index]
    before_filter :before_student_chooser, :only => :student_chooser

    def show
      super do |format|
        format.json { render :json => @course.as_json(:include => 'students') }
      end
    end

    def student_chooser
      @enrolled_students = @course.students.map {|i| i.id.to_s }
      selected_students
      respond_to do |format|
        format.js
      end
    end


    private

      def count
        @count = Course.count
      end

      def before_student_chooser
        @course = Course.find(params[:course_id])
        @courses = Course.all

        @search = Student.search(params[:q])
        @students = @search.result
      end

      def before_index
        @course = Course.new
        @syllabuses = Syllabus.all
      end

  	  def before_show
  		  @new_course_enrollment = CourseEnrollment.new
        @class_groups = ClassGroup.all
        @notable = Course.find(params[:id])
        @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")
  	  end

      def selected_students
        params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]
      end

      def sort_column
        Student.column_names.include?(params[:sort]) ? params[:sort] : 'surname'
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
      end

  end
end
