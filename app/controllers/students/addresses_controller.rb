class Students::AddressesController < ApplicationController

  before_filter :load_student, :only => [ :new, :create, :edit, :update ]

  def new
    @student.addresses.build
    render 'students/addresses/new'  
  end
  
  def create
    if @student.update_attributes(params[:student])
      respond_to do |format|
        format.js { render 'students/addresses/create' }  
      end
    end  
  end

  def edit
    @address = Address.find(params[:id])
    respond_to do |format|
      format.js {render 'edit'}  
    end  
  end

  def update
    respond_to do |format|
      # Find student/show address row to update it
      format.js { render 'update' }  
    end  
  end

  def destroy
    #destroy! :flash => !request.xhr?
    @address.destroy  
    render :nothing => true
  end


  private 
    def load_student
      @student = Student.find(params[:student_id])
    end

end
