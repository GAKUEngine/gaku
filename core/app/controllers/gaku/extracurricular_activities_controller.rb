module Gaku
  class ExtracurricularActivitiesController < GakuController

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
