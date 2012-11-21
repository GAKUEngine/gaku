module Gaku
  class Students::ClassGroupEnrollmentsController < GakuController

    inherit_resources
    actions :new, :destroy

    respond_to :js, :html

    before_filter :student, :only => [:new, :create]
    before_filter :class_groups, :only => :new

    def create
      @class_group_enrollment = ClassGroupEnrollment.new(params[:class_group_enrollment])
      respond_to do |format|
        if @class_group_enrollment.save && @student.class_group_enrollments << @class_group_enrollment
          @class_group = ClassGroup.find(@class_group_enrollment.class_group_id)        
        end
        flash.now[:notice] = t('notice.enrolled', :resource => t('student.singular'), :to => resource_name)
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

    def resource_name
      t('class_group.singular')
    end

    def class_groups
      @class_groups = ClassGroup.all
    end
  end
end
