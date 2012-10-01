class Students::ContactsController < ApplicationController

  inherit_resources

  actions :index, :show, :create, :update, :edit, :destroy

  before_filter :load_student, :only => [ :new, :create, :edit, :update, :destroy ]

  def new
    @contact = Contact.new
    super do |format|
      format.js {render 'new'}
    end 
  end
  
  def create
    super do |format|
      if @contact.save && @student.contacts << @contact
        @contact.make_primary_student if params[:contact][:is_primary] == "1"
        format.js { render 'create' }
      end
    end
  end

  def edit
    super do |format|
      format.js { render 'edit' }  
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
    @contact = Contact.find(params[:id])
    if params[:guardian_id]
      #handle guardian contact make primary
    else
      #handle student contact make primary
      @contact.make_primary_student
      respond_with(@contact) do |format|
        format.js { render 'make_primary' }
      end
    end
  end

  private 
    def load_student
      @student = Student.find(params[:student_id])
    end
end
