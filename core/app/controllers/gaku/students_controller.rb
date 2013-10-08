module Gaku
  class StudentsController < GakuController

    # load_and_authorize_resource class: Gaku::Student,
    #                             except: [:recovery, :destroy]

    decorates_assigned :student

    helper_method :sort_column, :sort_direction

    respond_to :js,   only: %i( new create edit update index destroy recovery )
    respond_to :html, only: %i( index edit show show_deleted soft_delete )
    respond_to :pdf,  only: %i( index show )

    before_action :load_data,             only: %i( new edit )
    before_action :set_class_group,       only: %i( index new edit )
    before_action :set_selected_students, only: %i( create index )
    before_action :set_student,           only: %i( show edit update soft_delete )
    before_action :set_unscoped_student,  only: %i( show_deleted destroy recovery )

    def new
      @student = Student.new
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

      @count = Student.count

      @search = Student.active.search(params[:q])
      results = @search.result(distinct: true)
      @students = results.order('created_at ASC').page(params[:page])

      respond_with(@students) do |format|
        format.pdf do
          send_data render_to_string, filename: 'sido_yoroku.pdf',
                                      type: 'application/pdf',
                                      disposition: 'attachment'
        end
      end
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

    def show_deleted
      respond_with(@student) do |format|
        format.html { render :show }
      end
    end

    def destroy
      @student.destroy
      @count = Student.count
      respond_with @student
    end

    def recovery
      @student.recover
      flash.now[:notice] = t(:'notice.recovered', resource: t_resource)
      respond_with @student
    end

    def soft_delete
      @student.soft_delete
      @count = Student.count
      redirect_to students_path,
                  notice: t(:'notice.destroyed', resource: t_resource)
    end

    def update
      @student.update(student_params)
      respond_with(@student) do |format|
        if params[:student][:picture]
          format.html do
            redirect_to [:edit, @student],
                        notice: t(:'notice.uploaded', resource: t(:'picture'))
          end
        else
          format.html { redirect_to [:edit, @student] }
          format.js   { render }
          format.json { head :no_content }
        end
      end
    end

    def load_autocomplete_data
      object = "Gaku::#{params[:class_name].capitalize}".constantize
      @result = object.order(params[:column].to_sym)
                      .where(params[:column] + ' like ?', "%#{params[:term]}%")
      render json: @result.map(&params[:column].to_sym).uniq
    end


    private

    def student_params
      %i(name surname name_reading surname_reading birth_date gender class_group_ids scholarship_status_id enrollment_status_code commute_method_type_id admitted graduated picture)
    end

    def student_params
      params.require(:student).permit(attributes)
    end

    def attributes
      %i( name surname name_reading surname_reading birth_date gender class_group_ids scholarship_status_id enrollment_status_code commute_method_type_id admitted graduated picture )
    end

    def includes
      [[contacts: :contact_type, addresses: :country], :guardians]
    end

    def t_resource
      t(:'student.singular')
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

    def set_unscoped_student
      @student ||= Student.includes(includes).unscoped.find(params[:id])
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
