module Gaku
  class Students::ContactsController < GakuController

    inherit_resources
    actions :new, :create, :update, :edit, :destroy

    respond_to :js, :html

    before_filter :student, :only => [:new, :create, :edit, :update, :destroy]
    before_filter :contact, :only => :make_primary
    before_filter :contact_types, :only => [:new, :edit]
    
    def create
      super do |format|
        if @contact.save && @student.contacts << @contact
          @contact.make_primary_student if params[:contact][:is_primary] == "1"
        end
        format.js { render 'create' }
      end
    end

    def update
      super do |format|
        @contacts = Contact.where(:student_id => params[:student_id])
        @contact.make_primary_student if params[:contact][:is_primary] == "1"
        format.js { render 'update' }  
      end  
    end

    def destroy
      super do |format|
        if @contact.is_primary?
          @student.contacts.first.make_primary_student if @student.contacts.any?
          format.js { render }
        else
          format.js { render 'destroy' }
        end
      end
    end 

    def make_primary
      @contact.make_primary_student
      respond_with(@contact) do |format|
        format.js { render 'make_primary' }
      end
    end

    private

    def student
      @student = Student.find(params[:student_id])
    end

    def contact
      @contact = Contact.find(params[:id])
    end

    def contact_types
      @contact_types = Gaku::ContactType.all
    end
  end
end