module Gaku
  class Students::GuardiansController < GakuController

    #load_and_authorize_resource :student, class: Gaku::Student
    #load_and_authorize_resource :guardian, through: :student, class: Gaku::Guardian

    inherit_resources
    respond_to :js, :html

    before_filter :student
    before_filter :count, only: [:create,:destroy]
    before_action :set_unscoped_guardian,  only: %i( destroy recovery )
    before_action :set_guardian,           only: %i( soft_delete )

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
          format.html { redirect_to [:edit, student, @guardian], notice: t('notice.uploaded', resource: t('picture')) }
        else
          format.js { render }
          format.json { head :no_content }
         end
      end
    end

    def recovery
      @guardian.recover
      flash.now[:notice] = t(:'notice.recovered', resource: t_resource)
      respond_with @guardian
    end

    def soft_delete
      @guardian.soft_delete
      redirect_to student_guardians_path(@student),
                  notice: t(:'notice.destroyed', resource: t_resource)
    end

    protected

    def resource
      @guardian = Guardian.includes(contacts: :contact_type).find(params[:id]).decorate
    end

    def resource_params
      return [] if request.get?
      [params.require(:guardian).permit(guardian_attr)]
    end

    private

    def guardian_attr
      %i(name surname name_reading surname_reading birth_date gender relationship picture)
    end

    def student
      @student = Student.find(params[:student_id])
    end

    def set_guardian
      @guardian = Guardian.find(params[:id]).decorate
    end

    def set_unscoped_guardian
      @guardian = Guardian.unscoped.find(params[:id]).decorate
    end

    def t_resource
      t(:'guardian.singular')
    end

    def count
      @count = @student.guardians.count
    end

  end
end
