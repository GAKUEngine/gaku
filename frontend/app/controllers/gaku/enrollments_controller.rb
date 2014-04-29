module Gaku
  class EnrollmentsController < GakuController

    respond_to :js, only: %i( new create edit update destroy student_selection create_from_collection )

    before_action :set_enrollmentable
    before_action :set_enrollment, only: %i( edit update destroy )
    before_action :set_students, only: %i( new edit )

    def student_selection
      @enrollment = @enrollmentable.enrollments.new
      @student_selection = current_user.student_selection
    end

    def new
     @enrollment = @enrollmentable.enrollments.new
     respond_with @enrollment
    end

    def create_from_collection
      unless params[:selected_students].blank?
        @enrollments = []

        params[:selected_students].each  do |student_id|
          if Student.exists?(student_id)
            enrollment = @enrollmentable.enrollments.create!(student_id: student_id)
            @enrollments << enrollment
          end
        end
      end
    end

    def create
      @enrollment = @enrollmentable.enrollments.build(enrollment_params)
      @enrollment.save
      set_count
      respond_with @enrollment
    end

    def edit
      respond_with @enrollment
    end

    def update
      @enrollment.update(enrollment_params)
      respond_with @enrollment
    end

    def destroy
      @enrollment.destroy
      set_count
      respond_with @enrollment
    end

    private

    def set_enrollmentable
      resource, id = request.path.split('/')[1,2]
      @enrollmentable = resource.insert(0, 'gaku/').pluralize.classify.constantize.find(id)
      @enrollmentable_resource = @enrollmentable.class.to_s.demodulize.underscore.dasherize
    end

    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    def enrollment_params
      params.require(:enrollment).permit(attributes)
    end

    def attributes
      %i( student_id )
    end

    def set_count
      @count = @enrollmentable.reload.enrollments_count
    end

    def set_students
      @students = Student.all
    end

  end
end
