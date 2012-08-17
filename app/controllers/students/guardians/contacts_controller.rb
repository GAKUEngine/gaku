class Students::Guardians::ContactsController < ApplicationController
	
	inherit_resources
	
	actions :index, :show, :new, :create, :update, :edit, :destroy

	before_filter :load_guardian, :only => [:edit,:update, :create,:destroy, :show]
  before_filter :load_before_show, :only => [:edit,:update, :create,:show]


  def create
    @contact = @guardian.contacts.build(params[:contact])
    if @contact.save
      @contact.make_primary_guardian if params[:contact][:is_primary] == "1"
      respond_to do |format|
        format.js {render 'students/guardians/contacts/create'}
      end
    end
  end

  def edit
    super do |format|
      format.js {render 'students/guardians/contacts/edit'}  
    end  
  end

  def update
    super do |format|
      @contacts = Contact.where(params[:guardian_id])
      @contact.make_primary_guardian if params[:contact][:is_primary] == "1"
      format.js {render 'students/guardians/contacts/update'}
    end  
  end


   def destroy
    super do |format|
      if @contact.is_primary?
        @guardian.contacts.first.make_primary_guardian if @guardian.contacts.any?
      end
        format.js { render 'students/guardians/contacts/destroy'}
    end
  end 

	def make_primary
    @contact = Contact.find(params[:id])
    @contact.make_primary_guardian
    respond_with(@contact) do |format|
      format.js {render 'students/guardians/contacts/make_primary' }
    end
  end

  private

  def load_guardian
  	@guardian = Guardian.find(params[:guardian_id])
  end

  def load_before_show
    @student = Student.find(params[:student_id])
  end
end
