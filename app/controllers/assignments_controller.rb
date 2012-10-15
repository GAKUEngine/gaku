class AssignmentsController < ApplicationController

  inherit_resources
  actions :index, :show, :new, :create, :update, :edit, :destroy

  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    respond_to do |format|
      format.js { render :nothing => true }
    end
  end
  
end