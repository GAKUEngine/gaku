class Students::Guardians::ContactsController < ApplicationController
	
	inherit_resources
  actions :new, :update, :edit, :destroy

  respond_to :js, :html

	before_filter :load_guardian
  before_filter :load_student

  def create
    @contact = @guardian.contacts.build(params[:contact])
    if @contact.save
      @contact.make_primary_guardian if params[:contact][:is_primary] == "1"
      respond_to do |format|
        format.js { render 'create', :notice => 'Contact Created' }
      end
    end
  end

  def create_modal
    @contact = @guardian.contacts.build(params[:contact])
    if @contact.save
      @contact.make_primary_guardian if params[:contact][:is_primary] == "1"
      respond_to do |format|
        flash.now[:notice] = 'Contact Created'
        format.js { render 'create_modal' }
      end
    end
  end

  def update
    super do |format|
      @contacts = Contact.where(:guardian_id => params[:guardian_id])
      @contact.make_primary_guardian if params[:contact][:is_primary] == "1"
      format.js { render 'update' }
    end  
  end

   def destroy
    super do |format|
      if @contact.is_primary?
        @guardian.contacts.first.make_primary_guardian if @guardian.contacts.any?
      end
        format.js { render 'destroy' }
    end
  end 

	def make_primary
    @contact = Contact.find(params[:id])
    @contact.make_primary_guardian
    respond_with(@contact) do |format|
      format.js { render 'make_primary' }
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
