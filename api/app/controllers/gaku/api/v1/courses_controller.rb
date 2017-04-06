module Gaku
  module Api
    module V1
      class CoursesController < BaseController

        def index
          @courses = Course.all
          respond_to do |format|
            format.json { render json: @courses, root: :courses, adapter: :json }
            format.msgpack { render msgpack: @courses, root: :courses, adapter: :json }
          end
        end

      end

    end
  end
end
