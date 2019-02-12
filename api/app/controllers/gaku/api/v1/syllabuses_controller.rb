module Gaku
  module Api
    module V1
      class SyllabusesController < BaseController
        authorize_resource class: 'Gaku::Syllabus'

        before_action :set_syllabus, only: %i( show update destroy )

        def index
          @syllabuses = Syllabus.accessible_by(current_ability).page(params[:page ])
          collection_respond_to @syllabuses, root: :syllabuses
        end

        def show
          @syllabuses = Syllabus.accessible_by(current_ability)
          @syllabus = @syllabus
          member_respond_to @syllabus
        end

        def create
          @syllabus = CreateSyllabusService.call(current_user, syllabus_params)
          if @syllabus.success?
            member_respond_to @syllabus.result
          else
            fail @syllabus.errors[:base]
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
          @syllabus = Syllabus.accessible_by(current_ability).find(params[:id])
        end

        def syllabus_params
          params.require(syllabus_attrs)
          params.permit(syllabus_attrs)
        end

        def syllabus_attrs
          %i( name code )
        end

      end
    end
  end
end
