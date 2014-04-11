module Gaku
  class Admin::Schools::ProgramsController < Admin::BaseController

    respond_to :js,   only: %i( index new create destroy edit update show_program_levels show_program_specialties show_program_syllabuses )

    before_action :set_school
    before_action :set_program, only: %i( show_program_levels show_program_specialties show_program_syllabuses destroy edit show update )
    before_action :load_data,   only: %i( new edit )

    def index
      @programs = @school.programs
      respond_with @programs
    end

    def new
      @program = Program.new
      respond_with @program
    end

    def create
      @program = Program.new(program_params)
      @program.save
      @school.programs << @program
      set_count
      respond_with @program
    end

    def edit
    end

    def update
      @program.update(program_params)
      respond_with @program
    end

    def destroy
      @program.destroy
      set_count
      respond_with @program
    end

    def show_program_levels
    end

    def show_program_specialties
    end

    def show_program_syllabuses
    end

    private

    def program_params
      params.require(:program).permit(attributes)
    end

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

    def set_program
      @program = Program.find(params[:id])
    end

    def set_school
      @school = School.find(params[:school_id])
    end

    def set_count
      @count = @school.programs.count
    end

  end
end
