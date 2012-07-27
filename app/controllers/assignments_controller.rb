class AssignmentsController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def destroy
    #destroy! :flash => !request.xhr?
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    respond_to do |format|
      format.js { render :nothing => true }
    end
  end
  
end