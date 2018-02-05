module Gaku
  module Api
    module V1
      module Students
        class StudentGuardiansController < BaseController

          before_action :set_guardian
          before_action :set_student

          def create
            @student.guardians << @guardian
            member_respond_to @guardian
          end

          private

          def set_guardian
            @guardian = Guardian.find(params[:guardian_id])
          end

          def set_student
            @student = Student.find(params[:student_id])
          end

        end
      end
    end
  end
end
