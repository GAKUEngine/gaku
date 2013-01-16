module Gaku
  class Students::Guardians::AddressesController < GakuController

    inherit_resources
    actions :new, :create, :edit, :update
    respond_to :js, :html

    before_filter :address, :only => [:destroy, :make_primary]
    before_filter :student, :only => [:new, :create, :edit, :update]
    before_filter :guardian
    before_filter :count, :only => [:create,:destroy]

    def create
      @address = @guardian.addresses.create(params[:address])
      create!
    end

    def destroy
      if @address.destroy
        if @address.is_primary?
          @guardian.addresses.first.try(:make_primary)
        end
        flash.now[:notice] = t(:'notice.destroyed', :resource => t(:'address.singular'))
        respond_with(@address)
      end
    end

    def make_primary
      @address.make_primary
      respond_with @address
    end

    private

    def address
      @address = Address.find(params[:id])
    end

    def student
      @student = Student.find(params[:student_id])
    end

    def guardian
      @guardian = Guardian.find(params[:guardian_id])
    end

    def count
      @count = @guardian.addresses.count
    end

  end
end
