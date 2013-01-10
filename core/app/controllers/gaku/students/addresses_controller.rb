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

    def update
      @primary_address = StudentAddress.find_by_student_id_and_is_primary(params[:student_id], true)
      update!
    end

    def destroy
      student_address = StudentAddress.unscoped.find_by_student_id_and_address_id(@student.id, @address.id)
      if student_address.destroy
        respond_to do |format|
          format.js { render :nothing => true}
        end
      end
    end

    def recovery
      @student_address = StudentAddress.unscoped.find_by_student_id_and_address_id(@student.id, @address.id)
      @student_address.update_attribute(:is_deleted, false)
      @address.update_attribute(:is_deleted, false)
      render :nothing => true
    end

    def soft_delete
      @primary_address_id = @student.student_addresses.find_by_is_primary(true).try(:id)
      student_address = StudentAddress.find_by_student_id_and_address_id(@student.id, @address.id)
      student_address.update_attributes(:is_deleted => true, :is_primary => false)
      @address.update_attribute(:is_deleted, true)

      if student_address.id == @primary_address_id
        # change to where.not(:id => student_address.id) when Rails 4 are released!
        @student.student_addresses.where("id != #{student_address.id}").first.make_primary unless @student.student_addresses.blank?
      end

      flash.now[:notice] = t(:'notice.destroyed', :resource => @address)
      respond_to do |format|
        format.js { render }
      end
    end

    def make_primary
      @student_address = StudentAddress.find_by_student_id_and_address_id(@student.id, @address.id)
      @student_address.make_primary
      respond_with(@student_address)
    end

    private

    def address
      @address = Address.find(params[:id])
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
