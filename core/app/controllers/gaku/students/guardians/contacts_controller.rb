module Gaku
  class Students::Guardians::ContactsController < GakuController
  	
  	inherit_resources
    actions :new, :update, :edit, :destroy

    respond_to :js, :html

  	before_filter :guardian
    before_filter :student
    before_filter :contact, :only => :make_primary 
    before_filter :contact_types, :only => [:new, :edit]

    def create
      @contact = @guardian.contacts.build(params[:contact])
      if @contact.save
        @contact.make_primary_guardian if params[:contact][:is_primary] == "1"
        respond_to do |format|
          flash.now[:notice] = t('notice.created', :resource => resource_name)
          format.js { render 'create' }
        end
      end
    end

    def create_modal
      @contact = @guardian.contacts.build(params[:contact])
      if @contact.save
        @contact.make_primary_guardian if params[:contact][:is_primary] == "1"
        respond_to do |format|
          flash.now[:notice] = t('notice.created', :resource => resource_name)
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
      @contact.make_primary_guardian
      respond_with(@contact) do |format|
        format.js { render 'make_primary' }
      end
    end

    private

    def guardian
  	  @guardian = Guardian.find(params[:guardian_id])
    end

    def student
      @student = Student.find(params[:student_id])
    end

    def contact
      @contact = Contact.find(params[:id])
    end

    def contact_types
      @contact_types = ContactType.all
    end

    def resource_name
      t('contact.singular')
    end
  end
end
