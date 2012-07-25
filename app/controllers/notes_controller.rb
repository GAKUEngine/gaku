class NotesController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def new
    @student = Student.find(params[:student_id])
    @note = @student.notes.build
    respond_to do |format|
      format.html { render :partial => "students/new_note", :locals => {:student => @student} }
      format.json { render :json => @note }
    end    
  end
  
  def edit
    @note = Note.find(params[:id])
    @student = Student.find(params[:student_id])
    super do |format|
      format.js {render 'edit'}  
    end  
  end

  def create
    @student = Student.find(params[:student_id])
    @note = @student.notes.build(params[:note])

    if @note.save
      respond_to do |format|
        format.html { redirect_to @student }
        format.js   { render 'create' }
      end
    else
      redirect_to :back
    end
  end
  
  def update
    @student = Student.find(params[:student_id])
    super do |format|
      # Find student/show note row to update it
      format.js {render 'update'}  
    end  
  end

  def destroy
    #destroy! :flash => !request.xhr?
    @note = Note.find(params[:id])
    @note.destroy
    respond_to do |format|
      format.js { render :nothing => true }
    end
  end
  
end

