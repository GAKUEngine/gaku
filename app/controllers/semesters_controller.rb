class SemestersController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def destroy
    destroy! :flash => !request.xhr?
  end

  def create
  	super do |format|
  		format.js { render 'create'}
  	end
  end
  
end