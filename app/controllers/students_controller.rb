class StudentsController < ApplicationController
  include SheetHelper
  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_class_groups, :only => [:new, :edit]
  before_filter :load_before_show, :only => :show
  
  def index
    @students = Student.all

    if params[:action] == "get_csv_template"
      get_csv_template()
      return
    end
    respond_to do |format|
      format.html
      format.json {render :json => @students}
      format.csv { export_csv_index(@students)}
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
          Student.create!(:surname => row[0],
                         :name => row[1],
                         :surname_reading => row[2],
                         :name_reading => row[3])
          
        end

        @rowcount += 1
      end
    end

    render :student_import_preview
  end

  def new
    @student = Student.new
    #@student.profile.build
  end

  def edit
    @student = Student.find(params[:id])
  end
  
  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      redirect_to @student
    else
      render :edit
    end
  end
  
  def destroy
    destroy! :flash => !request.xhr?
  end

  def new_address
    @student = Student.find(params[:id])
    @student.addresses.build
  end

  def create_address
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      respond_to do |format|
        format.js {render 'create_address'}  
      end
    end  
  end

  def new_guardian
    @student = Student.find(params[:id])
    @student.guardians.build
  end

  def create_guardian
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      respond_to do |format|
        format.js {render 'create_guardian'}  
      end
    end  
  end

  private

    def load_class_groups
      @class_groups = ClassGroup.all
      @class_group_id ||= params[:class_group_id]
    end

    def load_before_show
      @new_guardian = Guardian.new
      @new_note = Note.new
      @new_course_enrollment = CourseEnrollment.new
      @notes = Note.all
      @class_groups = ClassGroup.all
    end

end
