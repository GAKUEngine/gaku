module Gaku
  module Api
    module V1
      class EnrollmentsController < BaseController
        before_action :set_enrollable

        def index
          @enrollments = @enrollable.enrollments.page(params[:page])
          collection_respond_to @enrollments, root: :enrollments
        end

        private

        def set_enrollable
          resource, id = request.path.split('/').values_at(3,4)
          @enrollable = "gaku/#{resource}".pluralize.classify.constantize.find(id)
        end
      end
    end
  end
end
