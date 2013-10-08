module Gaku
  class Admin::Schools::ProgramsController < Admin::BaseController

    authorize_resource class: false

    respond_to :js, :html

    inherit_resources
    belongs_to :school, parent_class: School

    before_filter :count, only: %i(create destroy)
    before_filter :program, only: %i(show_program_levels show_program_specialties show_program_syllabuses)
    before_filter :load_data, only: %i(new edit)

    protected

    def resource_params
      return [] if request.get?
      [params.require(:program).permit(attributes)]
    end

    private

    def attributes
      #permit :id for update nested attributes
      [:id, :name, :description,
       { program_specialties_attributes: [:id, :specialty_id, :_destroy] },
       { program_levels_attributes: [:id, :level_id, :_destroy] },
       { program_syllabuses_attributes: [:id, :syllabus_id, :_destroy] }]
    end

    def load_data
      @levels = Level.all
      @syllabuses = Syllabus.all
      @specialties = Specialty.all
    end

    def program
      @program = Program.find(params[:id])
    end

    def count
      school = School.find(params[:school_id])
      @count = school.programs.count
    end

  end
end
