module Gaku
  class Students::GuardiansController < GakuController

    load_and_authorize_resource :student, :class => Gaku::Student
    load_and_authorize_resource :guardian, :through => :student, :class => Gaku::Guardian

    inherit_resources
    respond_to :js, :html

    before_filter :student
    before_filter :count, :only => [:create,:destroy]

    def create
      super do |format|
        if @student.guardians << @guardian
          format.js { render }
        end
      end
    end

    def update
      super do |format|
        if params[:guardian][:picture]
          format.html { redirect_to [:edit, student, guardian], :notice => t('notice.uploaded', :resource => t('picture')) }
        else
          format.js { render }
          format.json { head :no_content }
         end
      end
    end

    protected

    def resource
      @guardian = Guardian.includes(:contacts => :contact_type).find(params[:id])
    end

    private

    def student
      @student = Student.find(params[:student_id])
    end

    def count
      @count = @student.guardians.count
    end

  end
end
