module Gaku
  class Students::ClassGroupEnrollmentsController < GakuController

    respond_to :js, :only: %i( new create destroy )

    before_action :student, only: %i( new create )
    before_action :set_class_groups, only: :new

    def new
      @class_group_enrollment = ClassGroupEnrollment.new
    end

    def create
      @class_group_enrollment = ClassGroupEnrollment.new(class_group_enrollment_params)
      @class_group_enrollment.save
      flash.now[:notice] = t(:'notice.enrolled', resource: t(:'student.singular'), to: t(:'class_group.singular'))
      respond_with @class_group_enrollment
    end

    def destroy
      @class_group_enrollment.destroy
      set_count
      render nothing: true
    end

    private

    def attributes
      %i( class_group_id seat_number student_id )
    end

    def class_group_enrollment_params
      params.require(:class_group_enrollment).permit(attributes)
    end

    def set_student
      @student = Student.find(params[:student_id])
    end

    def set_class_groups
      @class_groups = ClassGroup.all
    end

  end
end
