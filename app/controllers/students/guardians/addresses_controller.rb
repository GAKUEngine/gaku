class Students::Guardians::AddressesController < ApplicationController
	
	inherit_resources
	
	actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_address, :only => [:destroy, :make_primary]
	before_filter :load_student, :only => [:new,:create, :edit, :update]
	before_filter :load_guardian, :only => [:new, :create, :edit, :update, :destroy, :make_primary]
	before_filter :load_primary_address, :only => [:update, :destroy]


	def new
		super do |format|
			format.js { render 'students/guardians/addresses/new' }
		end	
	end

	def create
    super do |format|
      if @guardian.addresses << @address
        @primary_address_id = @guardian.guardian_addresses.find_by_is_primary(true).address.id rescue nil
        format.js { render 'students/guardians/addresses/create' }  
      end
    end  
  end
  
  def edit
    super do |format|
      format.js { render 'students/guardians/addresses/edit' }  
    end  
  end

  def update
    super do |format|
      format.js { render 'students/guardians/addresses/update' }  
    end  
  end

  def destroy 
    @primary_address_id = @guardian.guardian_addresses.find_by_is_primary(true).address.id rescue nil
    logger.debug "@primary_address_id: #{@primary_address_id} || @address.id: #{@address.id}"
    if @address.destroy

      if @address.id == @primary_address_id
        @guardian.guardian_addresses.first.make_primary unless @guardian.guardian_addresses.blank?
        respond_to do |format|
          format.js { render }
        end
      else
        render 'destroy'
      end
    end
  end

  def make_primary
    @guardian_address = GuardianAddress.find_by_guardian_id_and_address_id(@guardian.id,@address.id)
    @guardian_address.make_primary
    render :nothing => true
  end
  
private

  def load_address
    @address = Address.find(params[:id])
  end

  def load_student
    @student = Student.find(params[:student_id])
  end

  def load_guardian
    @guardian = Guardian.find(params[:guardian_id])
  end

	def load_primary_address
		@guardian = Guardian.find(params[:guardian_id])
    @primary_address_id = @guardian.guardian_addresses.find_by_is_primary(true).address.id rescue nil
  end

end