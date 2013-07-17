module Gaku
  module Admin
    class ContactTypesController < Admin::BaseController

      load_and_authorize_resource class: Gaku::ContactType

      inherit_resources
      respond_to :js, :html
      before_filter :count, only: [:create, :destroy, :index]

      protected

      def resource_params
        return [] if request.get?
        [params.require(:contact_type).permit(contact_type_attr)]
      end

      private

      def count
        @count = ContactType.count
      end

      def contact_type_attr
        %i(name)
      end

    end
  end
end
