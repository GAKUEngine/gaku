module Gaku
  class Students::AddressesController < GakuController
    inherit_resources
    belongs_to :student, :parent_class => Gaku::Student
    respond_to :js, :html

    before_filter :student,   :only => [:index, :destroy, :make_primary, :soft_delete]
    before_filter :address,   :only => [:destroy, :make_primary, :soft_delete, :recovery]
    before_filter :count,     :only => [:create, :destroy, :soft_delete, :recovery]

    def create
      @address = @student.addresses.create(params[:address])
      create!
    end

    def destroy
      super do |format|
        format.js { render :nothing => true }
      end
    end

    def recovery
      @address.update_attribute(:is_deleted, false)
      flash.now[:notice] = t(:'notice.recovered', :resource => t(:'address.singular'))
      respond_with @address
    end

    def soft_delete
      @address.update_attribute(:is_deleted, true)
      if @address.is_primary?
        @student.addresses.first.try(:make_primary)
      end

      flash.now[:notice] = t(:'notice.destroyed', :resource => t(:'address.singular'))
      respond_to do |format|
        format.js { render }
      end
    end

    def make_primary
      @address.make_primary
      respond_with(@address)
    end

    private

    def address
      @address = Address.unscoped.find(params[:id])
    end

    def student
      @student = Student.find(params[:student_id])
    end

    def count
      student
      @count = @student.addresses.count
    end

  end
end
