class ContactsController < ApplicationController

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  respond_to :js

  def create
  	if params[:guardian_id]
  		#handle contact create for guardian
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
  		#handle contact create for student
      @student = Student.find(params[:student_id])
      @contact = @student.contacts.build(params[:contact])
      if @contact.save
        @contact.make_primary_student if params[:contact][:is_primary] == "1"
        respond_with(@contact) do |format|
          format.js {render 'student_contact'}
        end
      else
        render :nothing => true
      end
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
