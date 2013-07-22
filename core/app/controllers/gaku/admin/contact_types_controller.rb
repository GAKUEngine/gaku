module Gaku
  class Admin::ContactTypesController < Admin::BaseController

    load_and_authorize_resource class: ContactType

    respond_to :js, :html

    inherit_resources

    before_filter :count, only: %i(create destroy index)

    protected

    def resource_params
      return [] if request.get?
      [params.require(:contact_type).permit(attributes)]
    end

    private

    def count
      @count = ContactType.count
    end

    def attributes
      %i(name)
    end

  end
end
