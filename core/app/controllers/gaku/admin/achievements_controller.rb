module Gaku
  module Admin
    class AchievementsController < Admin::BaseController
      inherit_resources
      respond_to :js, :html, :json
    end
  end
end

