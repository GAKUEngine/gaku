module Gaku
  class Students::StudentSpecialtiesController < GakuController

    inherit_resources
    belongs_to :student
    respond_to :js, :html

    before_filter :student
    before_filter :student_specialties, :only => :update
    before_filter :count, :only => [:index, :create, :destroy, :update]


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

    def student_specialties
      student
      @student_specialties = @student.student_specialties
    end

    def count
      @count = StudentSpecialty.count
    end

  end
end
