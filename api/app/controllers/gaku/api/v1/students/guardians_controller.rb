module Gaku
  module Api
    module V1
      module Students
        class GuardiansController < BaseController

          before_action :set_student

          def index
            @guardians = @student.guardians
            respond_to do |format|
              format.json { render json: @guardians, root: :guardians, adapter: :json }
              format.msgpack { render msgpack: @guardians, root: :guardians, adapter: :json }
            end
          end

          private

          def set_student
            @student = Gaku::Student.find(params[:student_id])
          end

        end
      end
    end
  end
end
