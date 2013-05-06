module Gaku
  class SchedulesController < GakuController

    inherit_resources

    def destroy
      destroy! flash: !request.xhr?
    end

  end
end
