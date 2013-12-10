module Gaku
  class Students::StudentSpecialtiesController < GakuController

    respond_to :js, only: %i( new create edit update index destroy )

    before_action :student
    before_action :set_specialties, only: %i( new edit )
    before_action :set_student_specialty, only: %i( edit update destroy )

    def new
      @student_specialty = StudentSpecialty.new
      respond_with @student_specialty
    end

    def create
      @student_specialty = @student.student_specialties.create!(student_specialty_params)
      set_count
      respond_with @student_specialty
    end

    def edit
    end

    def update
      @student_specialty.update(student_specialty_params)
      respond_with @student_specialty
    end

    def index
      @student_specialties = @student.student_specialties
      set_count
      respond_with @student_specialties
    end

    def destroy
      @student_specialty.destroy
      set_count
      respond_with @student_specialty
    end

    private

    def student_specialty_params
      params.require(:student_specialty).permit(student_specialty_attr)
    end

    def student_specialty_attr
      %i( specialty_id major )
    end

    def student
      @student ||= Student.find(params[:student_id]).decorate
    end

    def set_count
      @count = @student.student_specialties.count
    end

    def set_student_specialty
      @student_specialty = StudentSpecialty.find(params[:id])
    end

    def set_specialties
      @specialties = Specialty.all
    end

  end
end
