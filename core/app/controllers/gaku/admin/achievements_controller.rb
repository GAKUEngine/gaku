module Gaku
  module Admin
    class AchievementsController < Admin::BaseController

      load_and_authorize_resource class: Gaku::Achievement

      inherit_resources
      respond_to :js, :html

      before_filter :count, only: [:index, :create, :destroy]

      def create
        create! { [:admin, :achievements ] }
      end

       def update
        update! { [:admin, :achievements ] }
      end

      def resource_params
        return [] if request.get?
        [params.require(:achievement).permit(achievement_attr)]
      end

      private

      def count
        @count = Achievement.count
      end

      def achievement_attr
        %i(name description authority badge external_school_record)
      end

    end
  end
end

