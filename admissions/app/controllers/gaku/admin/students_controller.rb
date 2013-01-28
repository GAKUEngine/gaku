module Gaku
  module Admin
    class StudentsController < GakuController

      inherit_resources
      respond_to :js, :html

      before_filter :select_vars,       :only => [:index,:new, :edit]
      before_filter :before_show,       :only => :show
      before_filter :count,             :only => [:create, :destroy, :index]
      before_filter :selected_students, :only => [:create,:index]
      before_filter :unscoped_student,  :only => [:show, :destroy, :recovery]



      def update
        @student = get_student
        if @student.update_attributes(params[:student])
          respond_with(@student) do |format|
            unless params[:student].nil?
              if !params[:student][:addresses_attributes].nil?
                format.js { render 'students/addresses/create' }
              elsif !params[:student][:notes_attributes].nil?
                format.js { render 'students/notes/create' }
              else
                if !params[:student][:picture].blank?
                  format.html { redirect_to [:admin, @student], :notice => t('notice.uploaded', :resource => t('picture')) }
                else
                  format.js { render }
                end
              end
            end
            format.html { redirect_to @student }
          end

        else
          render :edit
        end
      end

      def edit_enrollment_status
        @student = Student.find(params[:id])
      end

      def enrollment_status
        @student = Student.find(params[:id])
        @student.update_attributes(params[:student])
        if @student.save
          respond_with @student
        end
      end

      protected

      def collection
        @search = Student.search(params[:q])
        results = @search.result(:distinct => true)

        @students_count = results.count
        @students = results.page(params[:page]).per(10)
      end

      private

      def unscoped_student
        @student = Student.unscoped.find(params[:id])
      end

      def select_vars
        @class_group_id ||= params[:class_group_id]
      end

      def class_name
        params[:class_name].capitalize.constantize
      end

      def selected_students
        params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]
      end

      def before_show
        # @primary_address = StudentAddress.where(:student_id => params[:id], :is_primary => true).first
        @notable = Student.unscoped.find(params[:id])
        @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")

        Student.unscoped.includes([{:contacts => :contact_type}]).find(params[:id])
      end

      def get_student
        Student.find(params[:id])
      end

      def count
        @count = Student.count
      end

      def sort_column
        Student.column_names.include?(params[:sort]) ? params[:sort] : "surname"
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
      end
    end
  end
end
