class Students::Guardians::AddressesController < ApplicationController
	
	inherit_resources
  actions :new, :create, :edit, :update

  respond_to :js, :html

  before_filter :load_address, :only => [:destroy, :make_primary]
	before_filter :load_student, :only => [:new, :create, :edit, :update]
	before_filter :load_guardian
	before_filter :load_primary_address, :only => [:update, :destroy]

	def create
    super do |format|
      if @guardian.addresses << @address
        load_primary_address        
        format.js { render 'create' }  
      end
    end  
  end

  def destroy 
    if @address.destroy

      if @address.id == @primary_address_id
        @guardian.guardian_addresses.first.make_primary unless @guardian.guardian_addresses.blank?
        respond_to do |format|
          flash.now[:notice] = t('addresses.destroyed')
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
      @primary_address = @guardian.guardian_addresses.find_by_is_primary(true)
    end

end