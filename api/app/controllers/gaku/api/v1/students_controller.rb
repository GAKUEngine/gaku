module Gaku
  module Api
    module V1
      class StudentsController < BaseController

        skip_before_action :authenticate_request
        before_action :set_student, except: %i( index create )

        def index
          @students = Student.includes(:primary_contact, :primary_address).all.page(params[:page])
          collection_respond_to @students, root: :students
        end

        def picture
          send_file @student.picture.path
        end

        def show
          member_respond_to @student
        end

        def create
          @student = Student.new(student_params)
          if @student.save!
            member_respond_to @student
          end
        end

        def update
          if @student.update!(student_params)
            member_respond_to @student
          end
        end

        def destroy
          if @student.destroy!
            member_respond_to @student
          end
        end

        private

        def set_student
          @student = Student.find(params[:id])
        end

        def student_params
          params.require(:student).permit(student_attributes)
        end

        def student_attributes
          %i(
            name surname name_reading surname_reading middle_name middle_name_reading
            birth_date gender enrollment_status_code picture
          )
        end

      end
    end
  end
end
