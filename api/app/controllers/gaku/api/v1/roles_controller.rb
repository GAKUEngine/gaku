module Gaku
  module Api
    module V1
      class RolesController < BaseController
        skip_before_action :authenticate_request

        def index
          @roles = Gaku::Role.all
          collection_respond_to @roles, root: :roles
        end

      end
    end
  end
end
