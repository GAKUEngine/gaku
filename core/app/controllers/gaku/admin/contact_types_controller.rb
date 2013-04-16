module Gaku
  module Admin
    class ContactTypesController < Admin::BaseController

      load_and_authorize_resource :class =>  Gaku::ContactType

      inherit_resources
      respond_to :js, :html
      before_filter :count, :only => [:create, :destroy, :index]

      private

      def count
      	@count = ContactType.count
      end

    end
  end
end
