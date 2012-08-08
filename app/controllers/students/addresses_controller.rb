class Students::AddressesController < ApplicationController

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_student, :only => [ :new, :create, :edit, :update, :destroy ]

  def new
    @address = Address.new
    render 'new'  
  end
  
  def edit
    super do |format|
      format.js {render 'edit'}  
    end  
  end

  def create
    super do |format|
      if @student.addresses << @address
        format.js { render 'create' }  
      end
    end  
  end
  
  def update
    super do |format|
      format.js { render 'update' }  
    end  
  end

  def destroy
    super do |format|
      format.js { render 'destroy' }
    end
  end

  def make_primary
    @student = Student.find(params[:student_id])
    @address = Address.find(params[:id])
    @student_address = StudentAddress.find_by_student_id_and_address_id(@student.id,@address.id)
    @student_address.make_primary
    render :nothing => true
  end

  private 
    def load_student
      @student = Student.find(params[:student_id])
    end

end
