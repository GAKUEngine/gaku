module Gaku
  class Students::Guardians::ContactsController < GakuController

  	inherit_resources
    belongs_to :guardian, :parent_class => Gaku::Guardian

    respond_to :js, :html

  	before_filter :guardian
    before_filter :student
    before_filter :contact, :except => [:new, :create, :create_modal]
    before_filter :count, :only => [:create, :destroy]

    def create_modal
      @contact = @guardian.contacts.build(params[:contact])
      if @contact.save
        flash.now[:notice] = t(:'notice.created', :resource => t(:'contact.singular'))
        respond_with(@contact)
      end
    end

    def destroy
      if @contact.destroy
        if @contact.is_primary?
          @guardian.contacts.first.try(:make_primary)
        end
      end
      flash.now[:notice] = t(:'notice.destroyed', :resource => t(:'contact.singular'))
      destroy!
    end

  	def make_primary
      @contact.make_primary
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
