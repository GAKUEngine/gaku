module Gaku
  class ClassGroupsController < GakuController

    helper_method :sort_column, :sort_direction
    
    inherit_resources
    actions :show, :new, :create, :edit, :update, :destroy

    respond_to :js, :html

    before_filter :load_before_index, :only => :index
    before_filter :load_before_show, :only => :show
    before_filter :class_group,  :only => [:destroy, :show]
    before_filter :class_groups_count, :only => [:create, :destroy]

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
    
    private

      def class_group
        @class_group = ClassGroup.find(params[:id])
      end

      def load_before_index
        @class_group = ClassGroup.new
      end

      def load_before_show
        @notable = ClassGroup.find(params[:id])
        @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")
        @course = Course.new
        @courses = Course.all
        @semester = Semester.new
        @class_group_course_enrollment = ClassGroupCourseEnrollment.new
      end

      def sort_column
        ClassGroup.column_names.include?(params[:sort]) ? params[:sort] : "name"
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
      end
      
      def class_groups_count
          @class_groups_count = ClassGroup.count
      end
  end
end
