module Gaku
  module Admin
    class Schools::ProgramsController < Admin::BaseController

      authorize_resource :class => false

      inherit_resources
      belongs_to :school, :parent_class => Gaku::School
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy]
      before_filter :load_program, :only => [:show_program_levels, :show_program_specialties, :show_program_syllabuses]
      before_filter :load_data

      private

      def load_data
        @levels = Level.all.collect { |l| [l.name, l.id] }
        @syllabuses = Syllabus.all.collect { |s| [s.name, s.id] }
        @specialties = Specialty.all.collect { |s| [s.name, s.id] }
      end

      def load_program
        @program = Gaku::Program.find(params[:id])
      end

      def count
        @school = School.find(params[:school_id])
        @count = @school.programs.count
      end

    end
  end
end
