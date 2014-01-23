module Gaku
  class StudentsController < GakuController

    decorates_assigned :student

    helper_method :sort_column, :sort_direction

    # respond_to :js,   only: %i( new create index destroy recovery )
    # respond_to :html, only: %i( index edit show show_deleted soft_delete update )
    respond_to :html, :js
    respond_to :pdf,  only: %i( index show )

    before_action :load_data,             only: %i( new edit )
    #before_action :set_class_group,       only: %i( index new edit )
    before_action :set_selected_students, only: %i( create index )
    before_action :set_student,           only: %i( show edit update destroy )

    def new
      @enrolled_status = EnrollmentStatus.where(code: 'enrolled').first_or_create!
      @last_student = Student.last

      @student = Student.new
      if @last_student
        @student.admitted = @last_student.admitted
        @student.enrollment_status_code = @last_student.enrollment_status_code

      end
      @student.class_group_enrollments.new
      respond_with @student
    end

    def create
      @student = Student.new(student_params)
      if @student.save
        @count = Student.count
        respond_with @student, location: [:edit, @student]
      else
        render :new
      end
    end

    def index
      @search = Student.active.search(params[:q])
      results = @search.result(distinct: true)
      @students = results.page(params[:page])
      @count = results.count

      respond_with(@students) do |format|
        format.pdf do
          send_data render_to_string, filename: 'sido_yoroku.pdf',
                                      type: 'application/pdf',
                                      disposition: 'attachment'
        end
      end
    end

    def chosen
      set_selected_students
      set_class_groups
      set_courses
      @extracurricular_activity = ExtracurricularActivity.find(params[:extracurricular_activity_id]) if params[:extracurricular_activity_id]
      @class_group = ClassGroup.find(params[:class_group_id]) if params[:class_group_id]

      @enrolled_students = params[:enrolled_students]
      @search = Student.active.search(params[:q])
      @students = @search.result(distinct: true)
    end

    def advanced_search
      set_countries
      set_enrollment_statuses
      @search = Student.active.search(params[:q])
      @students = @search.result(distinct: true)
    end

    def search
      if params[:q]
        if params[:q][:graduated_gteq]  || params[:q][:graduated_lteq] || params[:q][:admitted_gteq] || params[:q][:admitted_lteq]
          @search = Student.search(params[:q])
        else
          @search = Student.active.search(params[:q])
        end

        if params[:q][:birth_date_gteq]  || params[:q][:birth_date_lteq] || params[:q][:age_gteq] ||params[:q][:age_lteq]
          @search.sorts = 'birth_date desc'
        else
          @search.sorts = 'created_at desc'
        end

      else
        @search = Student.active.search(params[:q])
      end

      results = @search.result(distinct: true)
      @students = results.page(params[:page])
      @count = results.count

      render :index
    end


    def edit
      respond_with @student
    end

    def show
      respond_with @student do |format|
        format.pdf do
          send_data render_to_string, filename: "student-#{@student.id}.pdf",
                                      type: 'application/pdf',
                                      disposition: 'inline'
        end
      end
    end

    def destroy
      @student.destroy
      @count = Student.count
      respond_with @student
    end

    def update
      @student.update(student_params)
      respond_with @student, location: [:edit, @student]
    end


    private


    def student_params
      params.require(:student).permit(attributes)
    end

    def attributes
      [ :name, :surname, :name_reading, :surname_reading, :birth_date,
          :gender, :scholarship_status_id,
          :enrollment_status_code, :commute_method_type_id, :admitted,
          :graduated, :picture, class_group_enrollments_attributes: [:id, :class_group_id] ]
    end

    def includes
      [[contacts: :contact_type, addresses: :country], :guardians]
    end

    def set_class_group
      @class_group_id ||= params[:class_group_id]
    end

    def set_enrollment_statuses
      @enrollment_statuses = EnrollmentStatus.all.includes(:translations).collect{|p| [p.name, p.code]}
    end

    def set_countries
      @countries = Country.all
    end

    def set_class_groups
      @class_groups = ClassGroup.all
    end

    def set_courses
      @courses = Course.all
    end

    def load_data
      @class_groups = ClassGroup.all
      @enrollment_statuses = EnrollmentStatus.includes(:translations)
      @scholarship_statuses = ScholarshipStatus.includes(:translations)
      @commute_method_types = CommuteMethodType.includes(:translations)
    end

    def set_selected_students
      if params[:selected_students].nil?
        @selected_students = []
      else
        @selected_students = params[:selected_students]
      end
    end

    def set_notable
      @notable = @student
      @notable_resource = get_resource_name @notable
    end

    def set_student
      @student ||= Student.includes(includes).find(params[:id])
      set_notable
    end

    def sort_column
      Student.column_names.include?(params[:sort]) ? params[:sort] : 'surname'
    end

    def sort_direction
      if %w[asc desc].include?(params[:direction])
        params[:direction]
      else
        'asc'
       end
    end

  end
end
