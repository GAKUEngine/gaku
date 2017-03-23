module Gaku
  module Api
    module V1
      class StudentsController < BaseController

        def index
          render json: [Student.first].to_json
        end

      end
    end
  end
end
