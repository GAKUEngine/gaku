class NotesController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def new
    @note = Note.new
    respond_to do |format|
      format.html {render :partial => "note_fields"}
      format.json {render :json => @students}
    end    
  end
  
  def destroy
    destroy! :flash => !request.xhr?
  end
  
end

