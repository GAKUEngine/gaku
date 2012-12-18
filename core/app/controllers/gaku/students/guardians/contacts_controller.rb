module Gaku
  class Students::Guardians::ContactsController < GakuController

  	inherit_resources
    actions :new, :update, :edit, :destroy
    respond_to :js, :html

  	before_filter :guardian
    before_filter :student
    before_filter :contact, :except => [:new, :create, :create_modal]
    before_filter :count, :only => [:create, :destroy]

    def create
      @contact = @guardian.contacts.build(params[:contact])
      if @contact.save
        @contact.make_primary_guardian if params[:contact][:is_primary] == "1"
      end
      respond_with(@contact)
    end

    def create_modal
      @contact = @guardian.contacts.build(params[:contact])
      if @contact.save
        @contact.make_primary_guardian if params[:contact][:is_primary] == "1"
        respond_with(@contact)
      end
    end

    def update
      @contacts = Contact.where(:guardian_id => params[:guardian_id])
      @contact.make_primary_guardian if params[:contact][:is_primary] == "1"
      update!
    end

     def destroy
      super do |format|
        if @contact.is_primary?
          @guardian.contacts.first.make_primary_guardian if @guardian.contacts.any?
        end
        format.js { render }
      end
    end

  	def make_primary
      @contact.make_primary_guardian
      respond_with(@contact)
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

    def count
      @count = @guardian.contacts.count
    end

  end
end
