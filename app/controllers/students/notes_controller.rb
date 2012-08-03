class Students::NotesController < ApplicationController

  before_filter :load_student, :only => [ :new, :create, :edit, :update ]

  def new
    @note = @student.notes.build
    respond_to do |format|
      format.html { render :partial => "students/new_note", :locals => {:student => @student} }
      format.json { render :json => @note }
    end    
  end
  
  def edit
    @note = Note.find(params[:id])
    respond_to do |format|
      format.js {render 'edit'}  
    end  
  end

  def create
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

  private 
    def load_student
      @student = Student.find(params[:student_id])
    end
  
  
end

