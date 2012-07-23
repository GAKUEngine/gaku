class AddressesController < ApplicationController

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def destroy
    #destroy! :flash => !request.xhr?
    @address = Address.find(params[:id])
    @address.destroy
        
    redirect_to :back
  end
  
end