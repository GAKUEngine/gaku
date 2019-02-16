module Gaku
  module Api
    module V1
      module Students
        class AddressesController < BaseController

          before_action :set_student

          def index
            @addresses = @student.addresses
            collection_respond_to @addresses, root: :addresses
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
