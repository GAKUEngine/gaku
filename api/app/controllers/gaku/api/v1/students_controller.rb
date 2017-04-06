module Gaku
  module Api
    module V1
      class StudentsController < BaseController
        skip_before_action :authenticate_request

        def index
          @students = Student.all
          respond_to do |format|
            format.json { render json: @students, root: :students, adapter: :json }
            format.msgpack { render msgpack: @students, root: :students, adapter: :json }
          end
        end

      end
    end
  end
end
