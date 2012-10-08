class Students::Guardians::ContactsController < ApplicationController
	
	inherit_resources
	
	actions :index, :show, :new, :create, :update, :edit, :destroy

	before_filter :load_guardian, :only => [:new, :create, :create_modal, :edit, :update, :destroy, :show]
  before_filter :load_student, :only => [:new, :create, :create_modal, :edit, :update , :show]


  def new
    @contact = Contact.new
    super do |format|
      format.js { render 'students/guardians/contacts/new' }
    end 
  end

  def create
    @contact = @guardian.contacts.build(params[:contact])
    if @contact.save
      @contact.make_primary_guardian if params[:contact][:is_primary] == "1"
      respond_to do |format|
        format.js { render 'students/guardians/contacts/create', :notice => 'Contact Created' }
      end
    end
  end

  def create_modal
    @contact = @guardian.contacts.build(params[:contact])
    if @contact.save
      @contact.make_primary_guardian if params[:contact][:is_primary] == "1"
      respond_to do |format|
        flash.now[:notice] = 'Contact Created'
        format.js { render 'students/guardians/contacts/create_modal'}
      end
    end
  end

  def edit
    super do |format|
      format.js { render 'students/guardians/contacts/edit' }  
    end  
  end

  def update
    super do |format|
      @contacts = Contact.where(:guardian_id => params[:guardian_id])
      @contact.make_primary_guardian if params[:contact][:is_primary] == "1"
      format.js { render 'students/guardians/contacts/update' }
    end  
  end


   def destroy
    super do |format|
      if @contact.is_primary?
        @guardian.contacts.first.make_primary_guardian if @guardian.contacts.any?
      end
        format.js { render 'students/guardians/contacts/destroy' }
    end
  end 

	def make_primary
    @contact = Contact.find(params[:id])
    @contact.make_primary_guardian
    respond_with(@contact) do |format|
      format.js { render 'students/guardians/contacts/make_primary' }
    end
  end

  private

  def load_guardian
  	@guardian = Guardian.find(params[:guardian_id])
  end

  def load_student
    @student = Student.find(params[:student_id])
  end
end
