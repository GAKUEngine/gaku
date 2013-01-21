module Gaku
  class Students::StudentSpecialtiesController < GakuController

    inherit_resources
    belongs_to :student
    respond_to :js, :html

    before_filter :student

    def index
      @student_specialties = @student.student_specialties
      respond_with @student_specialties
    end

    def destroy
      super do |format|
        format.js { render }
      end
    end

    private

    def student
      @student = Student.find(params[:student_id])
    end

  end
end
