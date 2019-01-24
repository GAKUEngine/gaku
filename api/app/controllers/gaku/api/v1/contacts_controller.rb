module Gaku
  module Api
    module V1
      class ContactsController < BaseController
        skip_before_action :authenticate_request
        before_action :set_contactable


        def index
          @contacts = @contactable.contacts.all
          collection_respond_to @contacts, root: :contacts
        end

        def create
          @contact = @contactable.contacts.create(contact_params)
          member_respond_to @contact
        end

        private

        def contact_params
          params.require(contact_attributes)
          params.permit(contact_attributes)
        end


        def contact_attributes
          %i( contact_type_id data )
        end


        def set_contactable
          model_name = params[:model_name]
          @contactable = model_name.constantize.find(params[model_name.foreign_key])
        end


      end
    end
  end
end
