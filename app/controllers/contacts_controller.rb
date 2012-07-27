class ContactsController < ApplicationController

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def create
  	if params[:guardian_id]
  		@guardian = Guardian.find(params[:guardian_id])
	  	@contact = @guardian.contacts.build(params[:contact])
	  	if @contact.save
	  		respond_with do |format|
	  			format.js { render 'guardian_contact' }
	  		end
	  	else
        render :nothing => true
      end
  	else
  		#TODO handle contact create for student 
  	end
  end

  def make_primary
    @contact = Contact.find(params[:id])
    if params[:guardian_id]
      #handle guardian contact make primary
    else
      #handle student contact make primary
      @contact.make_primary_student
      respond_with(@contact) do |format|
        format.js {render 'student_make_primary'}
      end
    end
  end

  def destroy
    destroy! :flash => !request.xhr?
  end 
end
