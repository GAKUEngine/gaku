class Students::NotesController < ApplicationController
  
  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_student, :only => [ :new, :create, :edit, :update, :destroy ]

  def new
    @note = Note.new
    render 'students/notes/new'  
  end
  
  def edit
    super do |format|
      format.js {render 'edit'}  
    end  
  end

  def create
    super do |format|
      if @student.notes << @note
        format.js { render 'create' }  
      end
    end  
  end
  
  def update
    super do |format|
      format.js { render 'update' }  
    end  
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    respond_to do |format|
      format.js { render 'destroy' }
    end
  end

  private 
    def load_student
      @student = Student.find(params[:student_id])
    end

end
