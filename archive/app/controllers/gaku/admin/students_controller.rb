module Gaku
  class Admin::StudentsController < Admin::BaseController
    respond_to :html, only: :show

    decorates_assigned :student

    def show
      @student = Student.includes(includes).unscoped.find(params[:id])
      @notable = @student
      @notable_resource = get_resource_name @notable

      render 'gaku/students/show'
    end

    private

    def includes
      [[contacts: :contact_type, addresses: :country], :guardians]
    end

  end
end
