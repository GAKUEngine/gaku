module Gaku
  class Students::ClassGroupEnrollmentsController < GakuController

    load_and_authorize_resource :student, :class => Gaku::Student
    load_and_authorize_resource :class_group_enrollment, :through => :student, :class => Gaku::ClassGroupEnrollment

    inherit_resources
    actions :new, :create, :destroy
    respond_to :js, :html

    before_filter :student, :only => [:new, :create]

    def create
      @class_group_enrollment = ClassGroupEnrollment.new(params[:class_group_enrollment])
      respond_to do |format|
        if @class_group_enrollment.save && @student.class_group_enrollments << @class_group_enrollment
          @class_group = ClassGroup.find(@class_group_enrollment.class_group_id)
        end
        flash.now[:notice] = t('notice.enrolled', :resource => t('student.singular'), :to => t(:'class_group.singular'))
        format.js { render 'create' }
      end
    end

    def destroy
      super do |format|
        format.js { render :nothing => true }
      end
    end

    private

    def student
      @student = Student.find(params[:student_id])
    end

  end
end
