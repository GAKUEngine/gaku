module Gaku
  class StudentsController < GakuController
    include SheetHelper

    load_and_authorize_resource :class =>  Gaku::Student

    helper_method :sort_column, :sort_direction

    inherit_resources
    respond_to :js, :html
    respond_to :csv, :only => :csv
    respond_to :pdf, :only => :show


    before_filter :select_vars,       :only => [:index,:new, :edit]
    before_filter :notable,           :only => [:show, :edit]
    before_filter :count,             :only => [:create, :destroy, :index]
    before_filter :selected_students, :only => [:create,:index]
    before_filter :unscoped_student,  :only => [:show, :destroy, :recovery]
    before_filter :enrollment_statuses, :only => :edit

    def index
      @enrolled_students = params[:enrolled_students]
      index!
    end

    def show
      super do |format|
        format.pdf { send_data render_to_string, :filename => "student-#{@student.id}.pdf",
                                                 :type => 'application/pdf',
                                                 :disposition => 'inline'}
      end
    end

    def destroy
      if @student.destroy
        respond_with @student
      end
    end

    def recovery
      @student.update_attribute(:is_deleted, false)
      respond_with @student
    end

    def soft_delete
      @student.soft_delete
      redirect_to students_path, :notice => t(:'notice.destroyed', :resource => t(:'student.singular'))
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
      super do |format|
        if params[:student][:picture]
          format.html { redirect_to @student, :notice => t('notice.uploaded', :resource => t('picture')) }
        else
          format.js { render }
          format.json { head :no_content }
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

    def resource
      #@student = Student.includes(:contacts => :contact_type).find(params[:id])
      @student = Student.find(params[:id])
    end

    private

    def enrollment_statuses
      #@enrollment_statuses = EnrollmentStatus.all.to_json(:value => :id, :text => :name)
      @enrollments = []
      EnrollmentStatus.all.each do |e|
        @enrollments << {value: e.id, text: e.name}
      end

      @commutes = []
      CommuteMethodType.all.each do |e|
        @commutes << {value: e.id, text: e.name}
      end

      @sch = []
      ScholarshipStatus.all.each do |e|
        @sch << {value: e.id, text: e.name}
      end


    end

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

    def notable
      # @primary_address = StudentAddress.where(:student_id => params[:id], :is_primary => true).first
      @notable = Student.unscoped.find(params[:id])
      @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")

      #Student.unscoped.includes([{:contacts => :contact_type}]).find(params[:id])
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
