module Gaku
  class Students::ClassGroupEnrollmentsController < GakuController

    respond_to :js, only: %i( index new create destroy )

    before_action :set_student
    before_action :load_data

    def new
      @class_group_enrollment = @student.class_group_enrollments.build
      respond_with @class_group_enrollment
    end

    def create
      @class_group_enrollment = @student.class_group_enrollments.create(enrollment_params)
      set_count
      respond_with @class_group_enrollment
    end

    def index
      @class_group_enrollments = @student.class_group_enrollments
    end

    def destroy
      @class_group_enrollment = Gaku::Enrollment.find(params[:id])
      @class_group_enrollment.destroy!
      set_count
      respond_with @class_group_enrollment
    end

    private

    def enrollment_params
      params.require(:enrollment).permit(enrollment_attr)
    end

    def enrollment_attr
      %i( enrollmentable_id )
    end

    def set_student
      @student = Student.find(params[:student_id]).decorate
    end

    def set_count
      @count = @student.reload.class_groups_count
    end

    def load_data
      @class_groups = Gaku::ClassGroup.all
    end
  end
end
