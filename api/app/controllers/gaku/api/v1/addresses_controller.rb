module Gaku
  module Api
    module V1
      class AddressesController < BaseController
        skip_before_action :authenticate_request
        before_action :set_addressable

        def index
          @addresses = @addressable.addresses
          collection_respond_to @addresses, root: :addresses
        end

        def create
          create_service = AddressCreateService.call(@addressable, address_params)
          if create_service.success?
            member_respond_to create_service.result
          else
            render_service_errors(create_service.errors[:base])
          end
        end

        private

        def address_params
          params.permit(address_attributes)
        end


        def address_attributes
          %i(address1 address2 city state zipcode country_id)
        end


        def set_addressable
          model_name = params[:model_name]
          @addressable = model_name.constantize.find(params[model_name.foreign_key])
        end

      end
    end
  end
end
