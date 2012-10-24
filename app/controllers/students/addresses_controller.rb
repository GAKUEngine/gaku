class Students::AddressesController < ApplicationController

  inherit_resources
  actions :index, :show, :new, :update, :edit

  respond_to :js, :html

  before_filter :load_address, :only => :destroy
  before_filter :load_student, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :load_primary_address, :only => [:destroy]
  def create
    super do |format|
      if @address.save
        if @student.addresses << @address
          format.js { render 'create' }  
        end
      else
        format.js  { render 'validation_errors' }
      end
    end  
  end
  
  def update
    super do |format|
      @primary_address = StudentAddress.where(:student_id => params[:student_id], :is_primary => true).first
      if @address.save
        format.js { render 'update' }
      else
        format.js { render 'validation_errors' }
      end  
    end  
  end

  def destroy
    if @address.destroy
      flash.now[:notice] = t('addresses.destroyed')
      if @address.id == @primary_address.address_id
        @student.student_addresses.first.make_primary unless @student.student_addresses.blank?
        respond_to do |format|
          format.js { render }
        end
      else
        render 'destroy'
      end
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
    def load_address
      @address = Address.find(params[:id])
    end

    def load_student
      @student = Student.find(params[:student_id])
    end

    def load_primary_address
      @primary_address = @student.student_addresses.find_by_is_primary(true)
    end

end