module Gaku
  class StudentsController < GakuController

    load_and_authorize_resource class: Gaku::Student,
                                except: [:recovery, :destroy]

    helper_method :sort_column, :sort_direction

    inherit_resources
    respond_to :js, :html
    respond_to :pdf, only: :show

    before_filter :load_data
    before_filter :select_vars,       only: [:index,:new, :edit]
    before_filter :notable,           only: [:show, :edit]
    before_filter :count,             only: [:create, :destroy, :index]
    before_filter :selected_students, only: [:create,:index]
    before_filter :unscoped_student,  only: [:show, :destroy, :recovery]
    after_filter  :make_enrolled,     only: [:create]


    def index
      @enrolled_students = params[:enrolled_students]
      #index!
      # @enrollment_status_applicant_id = EnrollmentStatus.first_or_create(code: "applicant").id
      # @enrollment_status_enrolled_id = EnrollmentStatus.first_or_create(code: "enrolled").id
      active_enrollment_statuses_codes = Gaku::EnrollmentStatus.active.pluck(:code)

      super do |format|

        format.html do
          @students = Student.where(enrollment_status_code: active_enrollment_statuses_codes).page(params[:page]).per(Preset.students_per_page)
        end

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

    def destroy
      respond_with @student if @student.destroy
    end

    def recovery
      @student.update_attribute(:is_deleted, false)
      flash.now[:notice] = t(:'notice.recovered', resource: t_resource)
      respond_with @student
    end

    def soft_delete
      @student.soft_delete
      redirect_to students_path,
                  notice: t(:'notice.destroyed', resource: t_resource)
    end

    def update
      @student = get_student
      super do |format|
        if params[:student][:picture]
          format.html do
            redirect_to [:edit, @student],
                        notice: t(:'notice.uploaded', resource: t(:'picture'))
          end
        else
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
                                  .where(params[:column] + " like ?", "%#{params[:term]}%")
      render json: @result.map(&params[:column].to_sym).uniq
    end

    protected

    def collection
      @search = Student.search(params[:q])
      results = @search.result(distinct: true)

      @students = results.page(params[:page]).per(Preset.students_per_page)
    end

    def resource
      @student = Student.includes([contacts: :contact_type, addresses: :country])
                        .find(params[:id])
    end

    private

    def includes
      [:addresses, :class_groups, :class_group_enrollments]
    end

    def t_resource
      t(:'student.singular')
    end

    def unscoped_student
      @student = Student.unscoped.find(params[:id])
    end

    def select_vars
      @class_group_id ||= params[:class_group_id]
    end

    def load_data
      @achievements = Achievement.all.collect { |a| [a.name, a.id] }
      @class_groups = ClassGroup.all.collect { |s| [s.name.capitalize, s.id] }
      @enrollment_statuses =  EnrollmentStatus.all.collect { |es| [es.name, es.code] }
      @enrollment_statuses << [t('undefined'), nil]
      @scholarship_statuses = ScholarshipStatus.includes(:translations).collect { |p| [ p.name, p.id ] }
      @countries = Gaku::Country.all.sort_by(&:name).collect{|s| [s.name, s.id]}
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

    def get_student
      Student.find(params[:id])
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
