module Gaku
  module Api
    module V1
      class SyllabusesController < BaseController

        before_action :set_syllabus, only: %i( show update destroy )

        def index
          @syllabuses = Syllabus.all.page(params[:page])
          collection_respond_to @syllabuses, root: :syllabuses
        end

        def show
          member_respond_to @syllabus
        end

        def create
          @syllabus = Syllabus.new(syllabus_params)
          if @syllabus.save!
            member_respond_to @syllabus
          end
        end

        def update
          if @syllabus.update!(syllabus_params)
            member_respond_to @syllabus
          end
        end

        def destroy
          if @syllabus.destroy!
            member_respond_to @syllabus
          end
        end

        private

        def set_syllabus
          @syllabus = Syllabus.find(params[:id])
        end

        def syllabus_params
          params.require(:syllabus).permit(syllabus_attrs)
        end

        def syllabus_attrs
          %i( name code )
        end

      end
    end
  end
end
