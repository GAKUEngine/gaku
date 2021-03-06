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
          @syllabus_service = CreateSyllabusService.call(current_user, syllabus_params)
          if @syllabus_service.success?
            member_respond_to @syllabus_service.result
          else
            render_service_errors(@syllabus_service.errors[:base])
          end
        end

        def update
          if @syllabus.update(syllabus_params)
            member_respond_to @syllabus
          else
            render_service_errors(@syllabus.errors.full_messages)
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
          params.permit(syllabus_attrs)
        end

        def syllabus_attrs
          %i( name code )
        end

      end
    end
  end
end
