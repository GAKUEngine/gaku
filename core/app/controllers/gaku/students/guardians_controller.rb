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
      respond_with @guardian, location: [:edit, @student, @guardian]
    end

    def destroy
      @guardian.destroy
      set_count
      respond_with @guardian
    end

    def recovery
      @guardian.recover
      respond_with @guardian
    end

    def soft_delete
      @guardian.soft_delete
      set_count
      respond_with @guardian, location: edit_student_path(@student)
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

    def set_count
      @count = @student.reload.guardians_count
    end

  end
end
