class GuardiansController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  belongs_to :student
  
  def destroy
    destroy! :flash => !request.xhr?
  end

  def new_contact
  	@student = Student.find(params[:student_id])
  	@guardian = Guardian.find(params[:id])
  	@contact = Contact.new
  
  	respond_to do |format|
  		format.js {render 'new_contact'}
  	end
  end

  def edit
    @guardian = Guardian.find(params[:id])
    if params[:student_id]
      @student = Student.find(params[:student_id])
      super do |format|
        format.js {render 'edit_student_guardian'}  
      end  
    else
      super do |format|
        format.html
      end  
    end  
  end  

  def update
    if params[:student_id]
      @student = Student.find(params[:student_id])
      super do |format|
        # Find student/show guardian row to update it
        format.js {render 'update_student_guardian'}  
      end  
    end
  end

end

