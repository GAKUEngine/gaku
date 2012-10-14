module Admin
  class ContactTypesController < Admin::BaseController
   	
    inherit_resources 

    respond_to :js, :html

  end
end