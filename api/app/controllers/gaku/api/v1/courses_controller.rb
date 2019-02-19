module Gaku
  module Api
    module V1
      class CoursesController < BaseController
        load_and_authorize_resource class: 'Gaku::Course'

        before_action :set_course, only: %i( show update destroy )

        def index
          @courses = Course.all.page(params[:page])
          collection_respond_to @courses, root: :courses
        end

        def show
          member_respond_to @course
        end

        def create
          @course = Course.new(course_params)
          if @course.save!
            member_respond_to @course
          end
        end

        def update
          if @course.update!(course_params)
            member_respond_to @course
          end
        end

        def destroy
          if @course.destroy!
            member_respond_to @course
          end
        end

        private

        def set_course
          @course = Course.find(params[:id])
        end

        def course_params
          params.require(:code)
          params.permit(course_attrs)
        end

        def course_attrs
          %i( syllabus_id code )
        end

      end
    end
  end
end
