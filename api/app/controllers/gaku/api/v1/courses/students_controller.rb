module Gaku
  module Api
    module V1
      module Courses
        class StudentsController < BaseController
          before_action :set_course

          def index
            @students = @course.students.page(params[:page ])
            collection_respond_to @students, root: :students
          end

          private

          def set_course
            @course = Course.find(params[:course_id])
          end
        end
      end
    end
  end
end
