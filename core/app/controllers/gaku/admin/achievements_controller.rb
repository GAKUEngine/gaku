module Gaku
  class Admin::AchievementsController < Admin::BaseController

    load_and_authorize_resource class: Achievement

    respond_to :js, :html

    inherit_resources

    before_filter :count, only: %i(index create destroy)

    def create
      create! { [:admin, :achievements] }
    end

     def update
      update! { [:admin, :achievements] }
    end

    def resource_params
      return [] if request.get?
      [params.require(:achievement).permit(attributes)]
    end

    private

    def count
      @count = Achievement.count
    end

    def attributes
      %i(name description authority badge external_school_record)
    end

  end
end
