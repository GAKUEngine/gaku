module Gaku
  class StudentsController < GakuController

    # load_and_authorize_resource class: Gaku::Student,
    #                             except: [:recovery, :destroy]

    helper_method :sort_column, :sort_direction

    #decorates_assigned :student

    inherit_resources

    respond_to :js,   only: %i( new create edit update index destroy recovery )
    respond_to :html, only: %i( index edit show show_deleted soft_delete )
    respond_to :pdf,  only: %i( index show )

    before_filter :load_data,         only: %i( new edit )
    before_filter :select_vars,       only: [:index,:new, :edit]
    before_filter :notable,           only: [:show, :show_deleted, :edit]
    before_filter :count,             only: [:create, :destroy, :index]
    before_filter :selected_students, only: [:create,:index]
    before_action :set_unscoped_student,  only: %i( show_deleted destroy recovery )
    after_filter  :make_enrolled,     only: [:create]
    before_action :set_student,       only: %i( edit update soft_delete )


    def index
      @enrollment_statuses = EnrollmentStatus.all
      @countries = Country.all
      @class_groups = ClassGroup.all
      @enrolled_students = params[:enrolled_students]

      @search = Student.active.search(params[:q])
      results = @search.result(distinct: true)
      @students = results.order('created_at ASC').page(params[:page])

      super do |format|
        format.pdf do
          send_data render_to_string, filename: 'sido_yoroku.pdf',
                                      type: 'application/pdf',
                                      disposition: 'attachment'
        end
      end
    end

    def show
      super do |format|
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
      respond_with @student if @student.destroy
    end

    def recovery
      @student.recover
      flash.now[:notice] = t(:'notice.recovered', resource: t_resource)
      respond_with @student
    end

    def soft_delete
      @student.soft_delete
      redirect_to students_path,
                  notice: t(:'notice.destroyed', resource: t_resource)
    end

    def update
      super do |format|
        if params[:student][:picture]
          format.html do
            redirect_to [:edit, @student],
                        notice: t(:'notice.uploaded', resource: t(:'picture'))
          end
        else
          format.html { redirect_to [:edit, @student] }
          format.js { render }
          format.json { head :no_content }
        end
      end
    end

    def autocomplete_search
      term = Student.encrypt_name(params[:term])
      @students = Student.includes(includes)
                         .where('(encrypted_surname || " " || encrypted_name LIKE ?) OR (encrypted_name || " " || encrypted_surname LIKE ?) OR (encrypted_name LIKE ?) OR (encrypted_surname LIKE ?)', "%#{term}%", "%#{term}%", "%#{term}%",  "%#{term}%")
      @students_json = decrypt_students_fields(@students)
      render json: @students_json.as_json
    end

    def load_autocomplete_data
      object = 'Gaku::' + params[:class_name].capitalize
      @result = object.constantize.order(params[:column].to_sym)
                                  .where(params[:column] + ' like ?', "%#{params[:term]}%")
      render json: @result.map(&params[:column].to_sym).uniq
    end

    protected

    def resource
      @student = Student.includes([contacts: :contact_type, addresses: :country])
                        .find(params[:id]).decorate
    end

    def resource_params
      return [] if request.get?
      [params.require(:student).permit(student_attr)]
    end

    private

    def student_attr
      %i(name surname name_reading surname_reading birth_date gender class_group_ids scholarship_status_id enrollment_status_code commute_method_type_id admitted graduated picture)
    end

    def includes
      [:addresses, :class_groups, :class_group_enrollments]
    end

    def t_resource
      t(:'student.singular')
    end

    def select_vars
      @class_group_id ||= params[:class_group_id]
    end

    def load_data
      @class_groups = ClassGroup.all
      @enrollment_statuses = EnrollmentStatus.all
      @scholarship_statuses = ScholarshipStatus.includes(:translations)
      @commute_method_types = CommuteMethodType.all
    end

    def class_name
      params[:class_name].capitalize.constantize
    end

    def selected_students
      if params[:selected_students].nil?
        @selected_students = []
      else
        @selected_students = params[:selected_students]
      end
    end

    def notable
      @notable = Student.unscoped.find(params[:id])
      @notable_resource = get_resource_name @notable
    end

    def set_student
      @student = Student.find(params[:id])
    end

    def set_unscoped_student
      @student = Student.unscoped.find(params[:id]).decorate
    end


    def count
      @count = Student.count
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

    def make_enrolled
      @student.make_enrolled if @student.valid?
    end
  end
end
