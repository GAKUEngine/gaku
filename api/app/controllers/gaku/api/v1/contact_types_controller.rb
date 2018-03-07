module Gaku
  module Api
    module V1
      class ContactTypesController < BaseController
        skip_before_action :authenticate_request

        def index
          @contact_types = ContactType.all
          collection_respond_to @contact_types, root: :contact_types
        end

        def create
          @contact_types = ContactType.create!(contact_type_params)
          member_respond_to @contact_types
        end

        private

        def contact_type_params
          params.require(:name)
          params.permit(:name)
        end

      end
    end
  end
end
