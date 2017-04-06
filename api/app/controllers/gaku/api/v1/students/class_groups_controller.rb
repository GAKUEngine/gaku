module Gaku
  module Api
    module V1
      module Students
        class ClassGroupsController < BaseController

          before_action :set_student

          def index
            @class_groups = @student.class_groups
            respond_to do |format|
              format.json { render json: @class_groups, root: :class_groups, adapter: :json }
              format.msgpack { render msgpack: @class_groups, root: :class_groups, adapter: :json }
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
