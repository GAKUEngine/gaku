module Gaku
  class Students::ContactsController < GakuController

    inherit_resources
    belongs_to :student, :parent_class => Gaku::Student
    respond_to :js, :html

    before_filter :student
    before_filter :contact, :except => [:new, :create]
    before_filter :count,   :only => [:create, :destroy]

    def destroy
      if @contact.destroy
        if @contact.is_primary?
          @student.contacts.first.try(:make_primary)
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

    def student
      @student = Student.find(params[:student_id])
    end

    def contact
      @contact = Contact.find(params[:id])
    end

    def count
      @count = @student.contacts.count
    end
  end
end
