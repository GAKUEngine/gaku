module Gaku
  class Students::ContactsController < GakuController

    inherit_resources
    belongs_to :student, :parent_class => Gaku::Student
    respond_to :js, :html

    before_filter :student
    before_filter :contact, :except => [:new, :create]
    before_filter :count,   :only => [:create, :destroy]

    def create
      super do |format|
        if @contact.save && @student.contacts << @contact
          @contact.make_primary_student if params[:contact][:is_primary] == "1"
        end
        format.js { render }
      end
    end

    def update
      @contacts = Contact.where(:student_id => params[:student_id])
      @contact.make_primary_student if params[:contact][:is_primary] == "1"
      update!
    end

    def destroy
      if @contact.is_primary?
        @student.contacts.first.make_primary_student if @student.contacts.any?
      end
      destroy!
    end

    def make_primary
      @contact.make_primary_student
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
