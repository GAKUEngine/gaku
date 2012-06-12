class ExamsController < ApplicationController
  before_filter :authenticate_user!
  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def destroy
    destroy! :flash => !request.xhr?
  end
  
end

