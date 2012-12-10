module Gaku
  class Students::GuardiansController < GakuController

    inherit_resources
    actions :new, :edit, :update, :destroy, :index, :show

    respond_to :js, :html

    before_filter :student
    before_filter :primary_address, :only => :show
    before_filter :count, :only => [:create,:destroy]

    def create
      super do |format|
        if @student.guardians << @guardian
          format.js { render 'create' }
        end
      end
    end

    def new_contact
      guardian
    	@contact = Contact.new
    	respond_to do |format|
    		format.js { render 'new_contact' }
    	end
    end

    private

    def student
      @student = Student.find(params[:student_id])
    end

    def guardian
      @guardian = Guardian.find(params[:id])
    end

    def primary_address
      guardian
      @primary_address = @guardian.guardian_addresses.find_by_is_primary(true)
    end

    def count
      @count = @student.guardians.count
    end

  end
end
