class Students::NotesController < ApplicationController
  
  inherit_resources
  actions :index, :show, :new, :create, :update, :edit, :destroy

  respond_to :js, :html 

  before_filter :load_student

  def create
    super do |format|
      if @student.notes << @note
        format.js { render 'create' }  
      end
    end  
  end
  

  private 
    def load_student
      @student = Student.find(params[:student_id])
    end

end
