module Gaku
  class Students::Guardians::AddressesController < GakuController

    inherit_resources
    actions :new, :create, :edit, :update

    respond_to :js, :html

    before_filter :address, :only => [:destroy, :make_primary]
    before_filter :student, :only => [:new, :create, :edit, :update]
    before_filter :guardian
    before_filter :primary_address, :only => [:update, :destroy]
    before_filter :count, :only => [:create,:destroy]

    def create
      super do |format|
        if @guardian.addresses << @address
          primary_address
          format.js { render 'create' }
        end
      end
    end

    def destroy
      if @address.destroy
        if @address.id == @primary_address_id
          @guardian.guardian_addresses.first.make_primary unless @guardian.guardian_addresses.blank?
          respond_to do |format|
            format.js { render }
          end
        else
          respond_with(@address) do |format|
            format.js { render 'destroy'}
          end
        end
      end
    end

    def make_primary
      @guardian_address = GuardianAddress.find_by_guardian_id_and_address_id(@guardian.id,@address.id)
      @guardian_address.make_primary
      render :nothing => true
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

      def primary_address
        @primary_address = @guardian.guardian_addresses.find_by_is_primary(true)
      end

      def count
        @count = @guardian.addresses.count
      end

  end
end
