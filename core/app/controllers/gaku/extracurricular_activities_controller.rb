module Gaku
  class ExtracurricularActivitiesController < GakuController

    load_and_authorize_resource :class =>  Gaku::ExtracurricularActivity

    include StudentChooserController

    inherit_resources
    respond_to :js, :html

    before_filter :count, :only => [:create, :destroy, :index]

    private

    def count
      @count = ExtracurricularActivity.count
    end

  end
end
