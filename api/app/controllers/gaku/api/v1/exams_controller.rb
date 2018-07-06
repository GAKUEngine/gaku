module Gaku
  module Api
    module V1
      class ExamsController < BaseController
        skip_before_action :authenticate_request

        def index
          @exams = Exam.all.page(params[:page])
          collection_respond_to @exams, root: :exams
        end

      end
    end
  end
end
