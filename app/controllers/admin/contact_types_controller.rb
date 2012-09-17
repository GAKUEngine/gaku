module Admin
  class ContactTypesController < Admin::BaseController
   	
    inherit_resources

    actions :index, :show, :new, :create, :update, :edit, :destroy

   end
end