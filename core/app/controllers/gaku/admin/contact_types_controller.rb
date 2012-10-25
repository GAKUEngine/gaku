module Gaku 
  module Admin
    class ContactTypesController < Admin::BaseController
     	
      inherit_resources 
      actions :index, :show, :new, :create, :update, :edit, :destroy
      
      respond_to :js, :html

      before_filter :contact_types_count, :only => [:create, :destroy]

      def current_user
        @current_user = 'ala-bala'
        #@current_user ||= user_from_remember_token
      end

      private
        def contact_types_count 
        	@contact_types_count = ContactType.count
        end

    end
  end
end