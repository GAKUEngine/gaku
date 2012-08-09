class Students::GuardiansController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_student, :only => [ :new, :create, :edit, :update, :destroy ]

  def new
    @guardian = Guardian.new
    render 'new'  
  end
  
  def edit
    super do |format|
      format.js {render 'edit'}  
    end  
  end

  def create
    super do |format|
      if @student.guardians << @guardian
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
    super do |format|
      format.js { render 'destroy' }
    end
  end

  def new_contact
  	@student = Student.find(params[:student_id])
  	@guardian = Guardian.find(params[:id])
  	@contact = Contact.new
  
  	respond_to do |format|
  		format.js {render 'new_contact'}
  	end
  end

  private 
    def load_student
      @student = Student.find(params[:student_id])
    end

end

