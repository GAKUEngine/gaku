module Gaku
  module Api
    module V1
      module ClassGroups
        class StudentsController < BaseController
          before_action :set_class_group

          def index
            @students = @class_group.students.page(params[:page ])
            collection_respond_to @students, root: :students
          end

          private

          def set_class_group
            @class_group = ClassGroup.find(params[:class_group_id])
          end
        end
      end
    end
  end
end
