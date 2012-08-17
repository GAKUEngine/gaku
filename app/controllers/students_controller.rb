class StudentsController < ApplicationController
  include SheetHelper
  #before_filter :authenticate_user!

  inherit_resources
  actions :show, :new, :destroy

  before_filter :load_before_index, :only => :index
  before_filter :load_before_show,  :only => :show
  before_filter :load_class_groups, :only => [:new, :edit]
  before_filter :load_student,      :only => [:edit, :update]
  
  def index
    @students = Student.includes([:addresses, :class_groups, :class_group_enrollments]).all

    if params[:action] == "get_csv_template"
      get_csv_template
      return
    end

    respond_to do |format|
      format.html
      format.json do 
        render :json => @students.as_json(:methods => [:address_widget, :class_group_widget,:seat_number_widget]) 
      end  
      format.csv  { export_csv_index(@students) }
    end
  end

  def get_csv_template
    filename = "StudentRegistration.csv"
    registration_fields = ["surname", "name", "surname_reading", "name_reading", "gender", "phone", "email", "birth_date", "admitted"]
    content = CSV.generate do |csv|
      csv << registration_fields
      csv << translate_fields(registration_fields)
    end
    send_data content, :filename => filename
  end

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
  private :export_csv_index

  def import_student_list
    @rowcount = 0
    @csv_data = nil
    @status = "NO FILE"
    if params[:import_student_list][:file] != nil
      @status = "FILE FOUND"
      @csv_data = params[:import_student_list][:file].read
      CSV.parse(@csv_data) do |row|
        case @rowcount
        when 0 #field index
          #get mapping
        when 1 #titles
          #ignore
        else #process record
          Student.create!(:surname => row[0], :name => row[1], :surname_reading => row[2], :name_reading => row[3])
        end
        @rowcount += 1
      end
    end
    render :student_import_preview
  end

  def create
    super do |format|
      format.js { render }
    end
  end

  def edit
    super do |format|
      format.js { render }
    end
  end

  def update
    if @student.update_attributes(params[:student])
      respond_to do |format|
        unless params[:student].nil?
          if !params[:student][:addresses_attributes].nil?
            format.js { render 'students/addresses/create' }
          elsif !params[:student][:notes_attributes].nil?
            format.js { render 'students/notes/create' }             
          else
            if !params[:student][:picture].blank?
              format.html { redirect_to @student, :notice => t('students.picture_uploaded')}
            else
              format.js { render}
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
    destroy! :flash => !request.xhr?
  end

  def autocomplete_search
    # search only name or surname separate
    # @students = Student.where("name like ? OR surname like ?", "%#{params[:term]}%", "%#{params[:term]}%")
    # work only on sqlite3 and postgresql
    @students = Student.includes([:addresses, :class_groups, :class_group_enrollments]).where('(surname || " " || name LIKE ?) OR (name || " " || surname LIKE ?) OR (name LIKE ?) OR (surname LIKE ?)', "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%",  "%#{params[:term]}%")
    render json: @students.as_json(:methods => [:address_widget, :class_group_widget,:seat_number_widget]) 
  end

  private
    def load_before_index
      @student = Student.new
    end

    def load_before_show
      @new_contact = Contact.new
      #@new_guardian = Guardian.new
      #@new_note = Note.new
      #@new_course_enrollment = CourseEnrollment.new
      #@notes = Note.all
      #@class_groups = ClassGroup.all
      @primary_address = StudentAddress.where(:student_id => params[:id], :is_primary => true).first
    end

    def load_class_groups
      @class_groups = ClassGroup.all
      @class_group_id ||= params[:class_group_id]
    end

    def load_student
      @student = Student.find(params[:id])
    end

end
