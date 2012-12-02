module Gaku
  class Students::AddressesController < GakuController
    inherit_resources
    belongs_to :student, :parent_class => Gaku::Student
    respond_to :js, :html

    before_filter :student,   :only => [:destroy, :make_primary]
    before_filter :address,   :only => [:destroy, :make_primary]
    before_filter :count,     :only => [:create, :destroy]

    def update
      @primary_address = StudentAddress.where(:student_id => params[:student_id], :is_primary => true).first
      update!
    end

    def destroy
      @primary_address_id = @student.student_addresses.find_by_is_primary(true).id rescue nil
      if @address.destroy

        if @address.id == @primary_address_id
          @student.student_addresses.first.make_primary unless @student.student_addresses.blank?
          respond_with(@address) do |format|
            format.js { render }
          end
        else
          render :destroy
        end
      end
    end

    def make_primary
      student_address = StudentAddress.find_by_student_id_and_address_id(@student.id, @address.id)
      student_address.make_primary
      render :nothing => true
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
