module Gaku
  module Api
    module V1
      module Syllabuses
        class ExamsController < BaseController

          before_action :set_syllabus

          def index
            @exams = @syllabus.exams
            respond_to do |format|
              format.json { render json: @exams, root: :exams, adapter: :json }
              format.msgpack { render msgpack: @exams, root: :exams, adapter: :json }
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
