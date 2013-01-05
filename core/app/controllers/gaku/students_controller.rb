module Gaku
  class StudentsController < GakuController
    include SheetHelper
    helper_method :sort_column, :sort_direction

    inherit_resources
    respond_to :js, :html
    respond_to :csv, :only => :csv

    before_filter :select_vars,       :only => [:index,:new, :edit]
    before_filter :before_show,       :only => :show
    before_filter :count,             :only => [:create, :destroy, :index]
    before_filter :selected_students, :only => [:create,:index]

    def index
      @enrolled_students = params[:enrolled_students]
      index!
    end

    def csv
      @students = Student.all
      field_order = ["surname", "name"]

      content = CSV.generate do |csv|
        csv << translate_fields(field_order)
        @students.each do |student|
          csv << student.attributes.values_at(*field_order)
        end
      end

      send_data content,
          :type => 'text/csv; charset=utf-8; header=present',
          :disposition => "attachment; filename=students.csv"
    end

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
      destroy! { students_path }
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

    protected

    def collection
      @search = Student.search(params[:q])
      @students = @search.result(:distinct => true).page(params[:page]).per(10)
    end

    private

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
      @primary_address = StudentAddress.where(:student_id => params[:id], :is_primary => true).first
      @notable = Student.find(params[:id])
      @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")

      Student.includes([{:contacts => :contact_type}]).find(params[:id])
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
