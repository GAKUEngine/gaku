module Gaku
  class Students::GuardiansController < GakuController

    respond_to :js,   only: %i( new create destroy recovery )
    respond_to :html, only: %i( edit update soft_delete )

    before_action :set_student
    before_action :set_unscoped_guardian,  only: %i( destroy recovery )
    before_action :set_guardian,           only: %i( show edit update soft_delete )

    def new
      @guardian = Guardian.new
      respond_with @guardian
    end

    def create
      @guardian = Guardian.new(guardian_params)
      @student.guardians << @guardian
      set_count
      respond_with @guardian
    end

    def edit
    end

    def update
      @guardian.update(guardian_params)
      respond_with(@guardian) do |format|
        if params[:guardian][:picture]
          format.html { redirect_to [:edit, @student, @guardian], notice: t(:'notice.uploaded', resource: t(:'picture')) }
        else
          format.html { redirect_to [:edit, @student, @guardian] }
         end
      end
    end

    def destroy
      @guardian.destroy
      set_count
      respond_with @guardian
    end

    def recovery
      @guardian.recover
      flash.now[:notice] = t(:'notice.recovered', resource: t_resource)
      respond_with @guardian
    end

    def soft_delete
      @guardian.soft_delete
      redirect_to edit_student_path(@student),
                  notice: t(:'notice.destroyed', resource: t_resource)
    end

    private

    def guardian_params
      params.require(:guardian).permit(guardian_attr)
    end

    def guardian_attr
      %i( name surname name_reading surname_reading birth_date gender relationship picture )
    end

    def set_student
      @student = Student.find(params[:student_id])
    end

    def set_guardian
      @guardian = Guardian.includes(contacts: :contact_type).find(params[:id]).decorate
    end

    def set_unscoped_guardian
      @guardian = Guardian.unscoped.find(params[:id]).decorate
    end

    def t_resource
      t(:'guardian.singular')
    end

    def set_count
      @count = @student.reload.guardians_count
    end

  end
end
