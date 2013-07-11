module Gaku
  class Students::GuardiansController < GakuController

    #load_and_authorize_resource :student, :class => Gaku::Student
    #load_and_authorize_resource :guardian, :through => :student, :class => Gaku::Guardian

    inherit_resources
    respond_to :js, :html

    #defaults resource_class: Guardian,
    #         instance_name: 'guardian'

    before_filter :student
    before_filter :count, :only => [:create,:destroy]

    # def create
    #   super do |format|
    #     if @student.guardians << @guardian
    #       format.js { render }
    #     end
    #   end
    # end

    def create
      @guardian = @student.guardians.create(guardian_params)
      respond_with(@guardian) if @guardian.persisted?
    end

    def update
      @guardian = Gaku::Guardian.find(params[:id])
      respond_with(@guardian) if @guardian.update(guardian_params)
    end

    # def update
    #   super do |format|
    #     if params[:guardian][:picture]
    #       format.html { redirect_to [:edit, student, guardian], :notice => t('notice.uploaded', :resource => t('picture')) }
    #     else
    #       format.js { render }
    #       format.json { head :no_content }
    #      end
    #   end
    # end

    protected

    #def resource
    #  @guardian = Guardian.includes(:contacts => :contact_type).find(params[:id])
    #end

    # def resource_params
    #   return [] if request.get?
    #   [params.require(:guardian).permit(guardian_attr).merge(student_id: student)]
    # end

    private

    def guardian_params
      params.require(:guardian).permit!
    end

    def guardian_attr
      %i(name surname name_reading surname_reading birth_date gender relationship)
    end

    def student
      @student = Student.find(params[:student_id])
    end

    def count
      @count = @student.guardians.count
    end

  end
end
