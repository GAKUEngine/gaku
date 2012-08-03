class Students::NotesController < ApplicationController

  before_filter :load_student, :only => [ :new, :create, :edit, :update ]

  def new
    @student.notes.build
    render 'students/notes/new'  
  end
  
  def edit
    @note = Note.find(params[:id])
    respond_to do |format|
      format.js {render 'edit'}  
    end  
  end

  def create
    if @student.update_attributes(params[:student])
      respond_to do |format|
        format.js { render 'students/notes/create' }  
      end
    end  
  end
  
  def update
    @note = Note.find(params[:id])
    respond_to do |format|
      # Find student/show note row to update it
      format.js { render 'update' }  
    end  
  end

  def destroy
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