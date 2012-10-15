class Students::GuardiansController < ApplicationController

  inherit_resources
  actions :new, :edit, :update, :destroy, :index, :show

  respond_to :js, :html

  before_filter :load_student
  before_filter :load_primary_address, :only => :show

  def create
    super do |format|
      if @student.guardians << @guardian
        format.js { render 'create' }  
      end
    end  
  end

  def new_contact
  	@student = Student.find(params[:student_id])
  	@guardian = Guardian.find(params[:id])
  	@contact = Contact.new
  
  	respond_to do |format|
  		format.js { render 'new_contact' }
  	end
  end

  private
    def load_student
      @student = Student.find(params[:student_id])
    end

    def load_primary_address
      @guardian = Guardian.find(params[:id])
      @primary_address = @guardian.guardian_addresses.find_by_is_primary(true)
    end

end