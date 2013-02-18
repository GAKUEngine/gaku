module Gaku
  class ClassGroupsController < GakuController

    include StudentChooserController

    load_and_authorize_resource :class =>  Gaku::ClassGroup

    helper_method :sort_column, :sort_direction

    inherit_resources
    respond_to :js, :html

    expose :class_group


    before_filter :load_before_show, :only => :show
    before_filter :count, :only => [:create, :destroy, :index]

    def index
      @class_groups = ClassGroup.order(sort_column + " " + sort_direction)
    end


    private

      def load_before_show
        @notable = ClassGroup.find(params[:id])
        @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")
        # @course = Course.new
        @courses = Course.all
        @class_group_course_enrollment = ClassGroupCourseEnrollment.new
      end

      def sort_column
        ClassGroup.column_names.include?(params[:sort]) ? params[:sort] : "name"
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
      end

      def count
        @count = ClassGroup.count
      end
  end
end
