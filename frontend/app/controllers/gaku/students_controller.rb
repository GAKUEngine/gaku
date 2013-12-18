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
      @student = Student.new
      @student.class_group_enrollments.new
      respond_with @student
    end

    def create
      @student = Student.new(student_params)
      @student.save
      @student.make_enrolled if @student.valid?
      @count = Student.count
      respond_with @student
    end

    def index
      set_index_vars
      @enrolled_students = params[:enrolled_students]

      @search = Student.active.search(params[:q])
      results = @search.result(distinct: true)
      @count = results.count
      @students = results.order('created_at ASC').page(params[:page])

      respond_with(@students) do |format|
        format.pdf do
          send_data render_to_string, filename: 'sido_yoroku.pdf',
                                      type: 'application/pdf',
                                      disposition: 'attachment'
        end
      end
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

    def load_autocomplete_data
      object = "Gaku::#{params[:class_name].capitalize}".constantize
      @result = object.order(params[:column].to_sym)
                      .where(params[:column] + ' like ?', "%#{params[:term]}%")
      render json: @result.map(&params[:column].to_sym).uniq
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

    def set_index_vars
      @enrollment_statuses = EnrollmentStatus.all.includes(:translations)
      @countries = Country.all
      @class_groups = ClassGroup.all
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
