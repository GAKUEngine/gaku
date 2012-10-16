class StudentsController < ApplicationController
  include SheetHelper

  helper_method :sort_column, :sort_direction

  inherit_resources
  actions :show, :new, :destroy

  respond_to :js, :html

  before_filter :load_before_index, :only => :index
  before_filter :load_before_show,  :only => :show
  before_filter :class_groups,      :only => [:new, :edit]
  before_filter :student,           :only => [:edit, :update, :destroy]
  
  def index
    @search = Student.search(params[:q])
    @students = @search.result#.includes([:addresses, :class_groups, :class_group_enrollments]).all
    if params[:action] == "get_csv_template"
      get_csv_template
      return
    end

    @class_groups = ClassGroup.all
    @courses = Course.all

    params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]

    respond_to do |format|
      format.js
      format.html
      format.csv  { export_csv_index(@students) }
    end
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

  def create
    params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]
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
              format.html { redirect_to @student, :notice => t('notice.picture_uploaded')}
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
    if @student.destroy && !request.xhr?
      flash[:notice] = "Student was successfully destroyed."  
    end
    render :nothing => true
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
    @result = params[:class_name].capitalize.constantize.order(params[:column].to_sym).where(params[:column] + " like ?", "%#{params[:term]}%")
    render json: @result.map(&params[:column].to_sym).uniq
  end

  private
    def load_before_index
      @student = Student.new
    end

    def load_before_show
      @new_contact = Contact.new
      @primary_address = StudentAddress.where(:student_id => params[:id], :is_primary => true).first
      @notable = Student.find(params[:id])
    end

    def class_groups
      @class_groups = ClassGroup.all
      @class_group_id ||= params[:class_group_id]
    end

    def student
      @student = Student.find(params[:id])

    end

    def sort_column
      Student.column_names.include?(params[:sort]) ? params[:sort] : "surname"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

=begin
    def decrypt_students_fields(students)
      students_json = students.as_json(:methods => [:address_widget, :class_group_widget,:seat_number_widget])
      i = 0
      students_json.each {|student|
        student[:name] = @students[i].name
        student[:surname] = @students[i].surname
        student[:phone] = @students[i].phone
        student[:student] = @students[i]
        i += 1
      }
      return students_json
    end

    def decrypt_student_fields(student)
      student[:name] = @student.name
      student[:surname] = @student.surname
      student[:phone] = @student.phone
      student[:student] = @student
      return student
    end

    def sort_students(students_json)
      students_json.sort_by! { |hsh| hsh[sort_column.to_sym] }
      if sort_direction == "desc"
        students_json.reverse!
      end
      return students_json
    end
=end

end
