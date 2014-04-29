module Gaku
  class StudentsController < GakuController
    include PictureController

    decorates_assigned :student

    respond_to :html, :js

    before_action :load_data,             only: %i( new edit )
    before_action :set_selected_students, only: %i( create index )
    before_action :set_student,           only: %i( show edit update destroy )
    before_action :set_preset, only: %i( search advanced_search index )

    def new
      @enrolled_status = EnrollmentStatus.where(code: 'enrolled').first_or_create!
      @last_student = Student.last

      @student = Student.new
      if @last_student
        @student.admitted = @last_student.admitted
        @student.enrollment_status_code = @last_student.enrollment_status_code
      else
        @student.enrollment_status_code = @enrolled_status.code
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
      search
    end

    def chosen
      set_selected_students
    end

    def clear_search
      session[:q] = nil
      redirect_to students_path
    end

    def advanced_search
      @prefilled = session[:q].to_json
      set_countries
      set_enrollment_statuses
      @search = Student.active.search(params[:q])
      @students = @search.result(distinct: true)
    end

    def search
      if session[:q] != params[:q] && !params[:q].nil?
        session[:q] = params[:q]
      end

      if session[:q]

        search_unscoped = search_unscoped_params.any? { |k| session[:q].key?(k) }
        if search_unscoped == true
          @search = Student.includes(index_includes).search(session[:q])
        else
          @search = Student.includes(index_includes).active.search(session[:q])
        end

        sort_by_age = sort_age_params.any? { |k| session[:q].key?(k) }
        if sort_by_age == true
          @search.sorts = 'birth_date desc'
        else
          @search.sorts = 'created_at desc'
        end

      else
        @search = Student.includes(index_includes).active.search(params[:q])
      end

      results = @search.result(distinct: true)
      @students = results.page(params[:page])
      @count = results.count

      render :index, layout: 'gaku/layouts/index'
    end

    def edit
      respond_with @student
    end

    def show
      respond_with @student
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

    def index_includes
      [:enrollment_status, :user]
    end

    def search_unscoped_params
      %w(
           graduated_gteq graduated_lteq
           admitted_gteq admitted_lteq
           enrollment_status_code_eq
        )
    end

    def sort_age_params
      %w( birth_date_gteq birth_date_lteq age_gteq age_lteq )
    end


    def set_preset
      @preset = Preset.active
    end

    def set_enrollment_statuses
      @enrollment_statuses = EnrollmentStatus.all.includes(:translations).collect{|p| [p.name, p.code]}
    end

    def set_countries
      @countries = Country.all
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

  end
end
