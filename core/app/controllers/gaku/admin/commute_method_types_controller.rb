module Gaku
  class Admin::CommuteMethodTypesController < Admin::BaseController

    load_and_authorize_resource class: CommuteMethodType

    respond_to :js, :html

    inherit_resources

    before_filter :count, only: %i(create destroy index)

    protected

    def collection
      @commute_method_types = CommuteMethodType.includes(:translations)
    end

    def resource_params
      return [] if request.get?
      [params.require(:commute_method_type).permit(attributes)]
    end

    private

    def count
      @count = CommuteMethodType.count
    end

    def attributes
      %i(name)
    end

  end
end
