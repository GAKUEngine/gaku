module Gaku
  module Api
    module V1
      module Sylabuses
        class CoursesController < BaseController

          before_action :set_syllabus

          def index
            @courses = @syllabus.courses
            respond_to do |format|
              format.json { render json: @courses, root: :courses, adapter: :json }
              format.msgpack { render msgpack: @courses, root: :courses, adapter: :json }
            end
          end

          private

          def set_syllabus
            @syllabus = Gaku::Syllabus.find(params[:syllabus_id])
          end

        end
      end
    end
  end
end
