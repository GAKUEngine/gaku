module Admin
  class ContactTypesController < Admin::BaseController
   	
    inherit_resources 
    actions :index, :show, :new, :create, :update, :edit, :destroy
    
    respond_to :js, :html

    before_filter :contact_types_count, :only => [:create, :destroy]

    private
      def contact_types_count 
      	@contact_types_count = ContactType.count
      end

  end
end