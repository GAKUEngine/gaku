class AddressesController < ApplicationController

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def edit
    @address = Address.find(params[:id])
    @student = Student.find(params[:student_id])
    super do |format|
      format.js {render 'edit'}  
    end  
  end

  def update
    @student = Student.find(params[:student_id])
    super do |format|
      # Find student/show address row to update it
      
      format.js {render 'update'}  
    end  
  end

  def destroy
    #destroy! :flash => !request.xhr?
    @address = Address.find(params[:id])
    @address.destroy
        
    redirect_to :back
  end
  
end
