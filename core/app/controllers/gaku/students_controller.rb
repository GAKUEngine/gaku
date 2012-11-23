module Gaku
  class StudentsController < GakuController
    include SheetHelper
    helper_method :sort_column, :sort_direction

    inherit_resources
    respond_to :js, :html

    before_filter :load_before_index, :only => :index
    before_filter :load_before_show,  :only => :show
    before_filter :class_groups,      :only => [:new, :edit]
    before_filter :student,           :only => [:edit, :update, :destroy]
    before_filter :count,             :only => [:create, :destroy]
    before_filter :selected_students, :only => [:create,:index]

    def index
      @search = Student.search(params[:q])
      @students = @search.result(:distinct => true)#.includes([:addresses, :class_groups, :class_group_enrollments]).all
      if params[:action] == "get_csv_template"
        get_csv_template
        return
      end
      @enrolled_students = params[:enrolled_students]

      respond_to do |format|
        format.js
        format.html
        format.csv  { export_csv_index(@students) }
      end
    end

    def update
      if @student.update_attributes(params[:student])
        #flash.now[:notice] = t('notice.updated', :resource => resource_name)
        respond_with(student) do |format|
          unless params[:student].nil?
            if !params[:student][:addresses_attributes].nil?
              format.js { render 'students/addresses/create' }
            elsif !params[:student][:notes_attributes].nil?
              format.js { render 'students/notes/create' }
            else
              if !params[:student][:picture].blank?
                format.html { redirect_to @student, :notice => t('notice.uploaded', :resource => t('picture')) }
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

    def destroy
      if @student.destroy #&& !request.xhr?
        #flash[:notice] = t('notice.removed', :resource => resource_name)
        respond_with(@student) do |format|
          format.html { redirect_to students_path }
        end
      end
    end

    def autocomplete_search
      # search only name or surname separate
      # @students = Student.where("name like ? OR surname like ?", "%#{params[:term]}%", "%#{params[:term]}%")
      # work only on sqlite3 and postgresql
      term = Student.encrypt_name(params[:term])
      @students = Student.includes([:addresses, :class_groups, :class_group_enrollments]).where('(encrypted_surname || " " || encrypted_name LIKE ?) OR (encrypted_name || " " || encrypted_surname LIKE ?) OR (encrypted_name LIKE ?) OR (encrypted_surname LIKE ?)', "%#{term}%", "%#{term}%", "%#{term}%",  "%#{term}%")
      @students_json = decrypt_students_fields(@students)
      render json: @students_json.as_json
    end

    def load_autocomplete_data
      object = "Gaku::" + params[:class_name].capitalize
      @result = object.constantize.order(params[:column].to_sym).where(params[:column] + " like ?", "%#{params[:term]}%")
      render json: @result.map(&params[:column].to_sym).uniq
    end

    private

      def export_csv_index(students, field_order = ["surname", "name"])
        filename = "Students.csv"
        content = CSV.generate do |csv|
          csv << translate_fields(field_order)
          students.each do |student|
            csv << student.attributes.values_at(*field_order)
          end
        end
        send_data content, :filename => filename
      end

      def class_name
        params[:class_name].capitalize.constantize
      end

      def selected_students
        params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]
      end

      def load_before_index
        @student = Student.new
        @class_groups = ClassGroup.all
        @courses = Course.all
      end

      def load_before_show
        @new_commute_method = CommuteMethod.new
        @new_contact = Contact.new
        @primary_address = StudentAddress.where(:student_id => params[:id], :is_primary => true).first
        @notable = Student.find(params[:id])
        @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")
      end

      def class_groups
        @class_groups = ClassGroup.all
        @class_group_id ||= params[:class_group_id]
      end

      def student
        @student = Student.find(params[:id])
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

      def resource_name
        t('student.singular')
      end

  end
end
