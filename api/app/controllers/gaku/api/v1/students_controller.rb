module Gaku
  module Api
    module V1
      class StudentsController < BaseController

        before_action :set_student, except: %i( index create search)

        def index
          @students = Student.includes(:primary_contact, :primary_address).all
          collection_respond_to @students, root: :students
        end

        def picture
          send_file @student.picture.path
        end

        def show
          member_respond_to @student
        end

        def create
          create_service = StudentCreateService.call(student_params)
          if create_service.success?
            member_respond_to create_service.result
          else
            render_service_errors(create_service.errors[:base])
          end
        end

        def update
          if @student.update(student_params)
            member_respond_to @student
          else
            render_service_errors(@student.errors.full_messages)
          end
        end

        def destroy
          if @student.destroy!
            member_respond_to @student
          end
        end

        def search
          @q = Student.includes(:primary_contact, :primary_address).ransack(search_params)
          @students = @q.result

          collection_respond_to @students, root: :students
        end

        private

        def set_student
          @student = Student.find(params[:id])
        end

        def student_params
          params.permit(student_attributes)
        end

        def student_attributes
          %i(
            name surname name_reading surname_reading middle_name middle_name_reading
            birth_date gender enrollment_status_code picture foreign_id_code
          )
        end

        def search_params
          params.require(:q).permit(search_attrs)
        end

        def search_attrs
          %i[name_cont name_eq surname_cont surname_eq birth_date_eq]
        end

      end
    end
  end
end
