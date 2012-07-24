class GuardiansController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  belongs_to :student
  
  def destroy
    destroy! :flash => !request.xhr?
  end
  
end

