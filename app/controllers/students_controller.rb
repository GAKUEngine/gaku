class StudentsController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_class_groups, :only => [:new, :edit]

  def index
    @students = Student.all
    respond_to do |format|
      format.html
      format.json {render :json => @students}
    end
  end
  
  def show
    @new_profile = Profile.new
    @new_guardian = Guardian.new
    @notes = Note.all
    @new_note = Note.new
    
    @student = Student.find(params[:id])
    respond_to do |format|
      format.html
      format.json {render :json => @student}
    end
  end

  def create_note
    @note = Note.new(params[:new_note])
    
    if @note.update_attributes(params[:new_note])
      status = 'success'
    else
      status = 'error'
    end
    
    render json: { status: status, data: @note, html: html }
  end
  
  def destroy
    destroy! :flash => !request.xhr?
  end

  private
  
    def load_class_groups
      @class_groups = ClassGroup.all
      @class_group_id ||= params[:class_group_id]
    end

end
