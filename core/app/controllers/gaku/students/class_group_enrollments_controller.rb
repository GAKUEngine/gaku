module Gaku
  class Students::ClassGroupEnrollmentsController < GakuController

    load_and_authorize_resource :student, class: Gaku::Student
    load_and_authorize_resource :class_group_enrollment, through: :student, class: Gaku::ClassGroupEnrollment

    inherit_resources
    actions :new, :create, :destroy
    respond_to :js, :html

    before_filter :student, only: [:new, :create]
    before_filter :load_data

    def create
      @class_group_enrollment = ClassGroupEnrollment.new(class_group_enrollment_params)
      respond_to do |format|
        if @class_group_enrollment.save && @student.class_group_enrollments << @class_group_enrollment
          @class_group = ClassGroup.find(@class_group_enrollment.class_group_id)
        end
        flash.now[:notice] = t('notice.enrolled', resource: t('student.singular'), to: t(:'class_group.singular'))
        format.js { render 'create' }
      end
    end

    def destroy
      super do |format|
        format.js { render nothing: true }
      end
    end

    protected

    def resource_params
      return [] if request.get?
      [params.require(:class_group_enrollment).permit(class_group_enrollment_attr)]
    end

    private

    def class_group_enrollment_attr
      %i(class_group_id seat_number student_id)
    end

    def class_group_enrollment_params
      params.require(:class_group_enrollment).permit(class_group_enrollment_attr)
    end

    private

    def student
      @student = Student.find(params[:student_id])
    end

    def load_data
      @class_groups = ClassGroup.all.map { |s| [s.name.capitalize, s.id] }
    end

  end
end
