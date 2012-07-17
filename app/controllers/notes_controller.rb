class NotesController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def new
    @note = Note.new

    respond_to do |format|
      format.html {render :partial => "students/new_note"}
      format.json {render :json => @note}
    end    
  end
  
  def create
    @note = Noew.new(params[:note])

    if @note.update_attributes(params[:note])
      status = 'success'
      #html = render_to_string partial: 'show', locals: { note: @note }
    else
      status = 'error'
    end
  
    render json: { status: status, data: @memo, html: html }    
  end
  
  def destroy
    destroy! :flash => !request.xhr?
  end
  
end

